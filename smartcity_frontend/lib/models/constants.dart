/*
Configs
 */

//final String serverUri = 'broker.hivemq.com';
///Disguised for public release
final String serverUri = '0.0.0.0';
//final int port = 1883;
final int port = 8883;
const username = 'Gruppe4';
///Disguised for public release
const password = '...';
final String exampleTopic = "Dart/Mqtt_client/testtopic";

/// List Types
enum ListType {
  Worker,
  Sensor
}

/// MESSAGES, used for MQTT
const String ERROR_CONNECTING = 'MQTTClientWrapper::'
    'ERROR Mosquitto client connection failed - disconnecting, status is';
const String CONNECTED = 'MQTTClientWrapper::Mosquitto client connected';
const String CLIENT_EXCEPTION = 'MQTTClientWrapper::client exception -';
const String CURRENTLY_CONNECTING = 'MQTTClientWrapper::'
    'Mosquitto client connecting....';
const String SUBSCRIPTION_CONFIRMED = 'MQTTClientWrapper::'
    'Subscription confirmed for topic';
const String DISCONNECTED_CALLBACK = 'MQTTClientWrapper::'
    'OnDisconnected client callback - Client disconnection';
const String DISCONNECT_SOLICITED = 'MQTTClientWrapper::'
    'OnDisconnected callback is solicited (Client disconnected)';
const String CONNECTED_CALLBACK = 'MQTTClientWrapper::'
    'OnConnected client callback - Client connection was sucessful';
const String SUBSCRIBED_BEFORE_CONNECTED = 'MQTTCLIENTWRAPPER::'
    'Client is not yet connected, added subscription to waiting list.';
const String NOT_CONNECTED = 'MQTTClIENTWRAPPER::'
    'Action not possible, client is not connected.';
