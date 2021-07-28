import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'constants.dart' as constants;

///A MQTT connector used to publish mqtt messages
class MQTTProvider {
  ///TODO make unique name
  final client = MqttServerClient(constants.serverUri, 'sg-emulator');

  ///Connects to the broker specified in constants.dart
  Future<int> connect() async {
    client.secure = true;
    client.port = constants.port;

    final context = SecurityContext.defaultContext;
    client.onBadCertificate = (dynamic a) => true;
    client.securityContext = context;
    client.setProtocolV311();

    /// Add the unsolicited disconnection callback
    client.onDisconnected = _onDisconnected;

    /// Add the successful connection callback
    client.onConnected = _onConnected;

    /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
    client.onSubscribed = _onSubscribed;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password, the default keepalive interval(60s)
    /// and clean session, an example of a specific one below.
    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .startClean(); // Non persistent session for testing
    print('MQTT::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
    /// never send malformed messages.
    try {
      await client.connect(constants.username, constants.password);
    } on Exception catch (e) {
      print('MQTT::client exception - $e');
      client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('MQTT::Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'MQTT::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }

    return 0;
  }

  ///Publishes message to given topic
  Future<void> publish(String message, String topic) async {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print('MQTT::Publishing message $message to topic $topic');
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload);
    await MqttUtilities.asyncSleep(1);
  }

  ///Disconnects from the broker
  void disconnect() {
    print('MQTT::Disconnecting');
    client.disconnect();
  }

  /// The subscribed callback
  void _onSubscribed(String topic) {
    print('MQTT::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void _onDisconnected() {
    print('MQTT::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('MQTT::OnDisconnected callback is solicited, this is correct');
    }
    exit(-1);
  }

  /// The successful connect callback
  void _onConnected() {
    print(
        'MQTT::OnConnected client callback - Client connection was sucessful');
  }
}
