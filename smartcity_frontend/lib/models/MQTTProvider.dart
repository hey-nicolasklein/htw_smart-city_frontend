import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smartcity_frontend/models/ServiceProvider.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'constants.dart' as Constants;
import 'models.dart';

/// Is used by the [MQTTCubit] and the [MQTTProvider] to store
/// utf-8 encoded messages as a string with the associated time-stamp.
class DatedString{
  String message;
  DateTime time;

  DatedString(this.message, this.time);
}

/// Is used by the [MQTTProvider] to store received messages.
/// Each message is saved as a [DatedString]
class MqttCubits extends Cubit<Map<String, List<DatedString>>> {
  MqttCubits() : super({});

  void addNewMessage(String topic, String message){
    Map<String,List<DatedString>> clone = {}..addAll(state);
    clone.update(topic, (v) {
      //print('old list before update to recieved message list: ' + v.toString());
      return [...v]..insert(0, DatedString(message, DateTime.now()));
    }, ifAbsent: (){
      //print('new key named $topic with value $message created');
      return [DatedString(message, DateTime.now())];
    });

    emit(clone);
  }
}

/// This class manages the MQTT connection. All subscribing and publishing
/// is done here. Because the class is using the Singleton pattern it is accessible
/// everywhere. To start a connection to the Broker defined in [constants.dart]
/// call the [prepareClient] method.
class MQTTProvider {
  ///MQTTProvider instance
  static final MQTTProvider _singleton = MQTTProvider._internal();

  ///Singleton constructor
  factory MQTTProvider() {
    return _singleton;
  }

  ///Internal Constructor
  MQTTProvider._internal();

  ///Cubit that stores received messages as [DatedString]
  MqttCubits cubit = MqttCubits();

  /// [MqttServerClient] instance used to communicate
  MqttServerClient client;

  /// Current Connection State
  MQTTConnectionState connectionState = MQTTConnectionState.IDLE;

  /// List of currently subscribed topics
  List<String> subscribedList = [];

  /// Subscribe When Ready / connected
  List<String> waitingToSubscribeList = [];

  /// Called to establish a connection to the broker configured in [constants.dart]
  void prepareClient() async {
    _setupClient();
    await _connectClient();
    _setupSubscribe();
  }

  /// Creates a new [MqttServerClient] instance with the settings configured in
  /// [constants.dart]. Then goes on to register the connect, disconnect and
  /// subscribed callbacks.
  void _setupClient() {
    client = MqttServerClient(Constants.serverUri, 'sg-emulator');
    client.logging(on: false);
    client.keepAlivePeriod = 60;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
  }


  /// Sets up the [_onMessageReceivedCallback]
  void _setupSubscribe() {
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final String newDataJson =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      if (newDataJson != null)
        _onMessageReceivedCallback(c[0].topic, newDataJson);
    });
  }

  /// Connects the client to the MQTT-Broker specified in [constants.dart]
  Future<void> _connectClient() async {
    client.secure = true;
    client.port = Constants.port;

    final context = SecurityContext.defaultContext;
    client.onBadCertificate = (dynamic a) => true;
    client.securityContext = context;
    client.setProtocolV311();

    try {
      print(Constants.CURRENTLY_CONNECTING);
      connectionState = MQTTConnectionState.CONNECTING;
      await client.connect(Constants.username, Constants.password);
    } on Exception catch (e) {
      print(Constants.CLIENT_EXCEPTION + '$e');
      connectionState = MQTTConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }

    if (client.connectionStatus.state == MqttConnectionState.connected) {
      this.connectionState = MQTTConnectionState.CONNECTED;
      print(Constants.CONNECTED);
    } else {
      print(Constants.ERROR_CONNECTING + '${client.connectionStatus}');
      this.connectionState = MQTTConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
  }

  /// Used to subscribe to a topic, before the client successfully connects.
  /// The topic name is stored in [waitingToSubscribeList].
  /// When the client successfully connected, the [_subscribeWhenReadyCallback]
  /// is used to subscribe to each stored topic.
  void subscribe(String topicName) {
    if (this.connectionState == MQTTConnectionState.CONNECTED) {
      if (!subscribedList.contains(topicName)) {
        this._subscribe(topicName);
      }
    } else {
      print(Constants.SUBSCRIBED_BEFORE_CONNECTED);
      waitingToSubscribeList.add(topicName);
    }
  }

  /// Subscribes to a new topic defined by [topicName] and listens for
  /// new mqtt message with any of the topics subscribed to.
  void _subscribe(String topicName) {
    print('MQTTClientWrapper::Subscribing to the $topicName topic');
    Subscription s = client.subscribe(topicName, MqttQos.atMostOnce);
    if (s == null) {
      print('MQTTClientWrapper::Error subscribing to the $topicName topic');
    }
  }

  /// Is called after the client successfully connected to the broker.
  /// Now every topic stored in the [waitingToSubscribeList] will be subscribed to.
  void _subscribeWhenReadyCallback() {
    waitingToSubscribeList.forEach((topicName) => this._subscribe(topicName));
  }

  /// Unsubscribes from the [topic].
  void unsubscribe(String topic) {
    client.unsubscribe(topic);
    subscribedList.remove(topic);
  }

  /// If a new not null message is received, this message gets called.
  /// It searched through the subscribedObjects list for any subscriber
  /// to the message's topic. If one is found, the onMessageCallback method is
  /// called on that subscribe-able widget.
  void _onMessageReceivedCallback(String topic, String message) {
    ServiceProvider().onMessage(topic, message);
    cubit.addNewMessage(topic, message);
  }

  /// Publishes a message to a given topic if the client is connected.
  void publishMessage(String message, String topic) {
    if (this.connectionState == MQTTConnectionState.CONNECTED) {
      final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
      builder.addString(message);

      print('MQTTClientWrapper::Publishing message $message to topic $topic');
      client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload);
    } else {
      print(Constants.NOT_CONNECTED);
    }
  }


  /// Called when subscription was successful.
  void _onSubscribed(String topic) {
    print(Constants.SUBSCRIPTION_CONFIRMED + ' $topic');
    waitingToSubscribeList.remove(topic);
    subscribedList.add(topic);
  }


  /// Called when disconnected form the broker.
  void _onDisconnected() {
    print(Constants.DISCONNECTED_CALLBACK);
    connectionState = MQTTConnectionState.DISCONNECTED;
  }

  /// Called when successful connected
  void _onConnected() {
    connectionState = MQTTConnectionState.CONNECTED;
    print(Constants.CONNECTED_CALLBACK);
    _subscribeWhenReadyCallback();
  }
}
