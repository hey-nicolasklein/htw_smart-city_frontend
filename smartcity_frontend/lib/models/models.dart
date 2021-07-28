import 'package:smartcity_frontend/models/MQTTProvider.dart';

/// Represents the current state of the [MQTTProvider]
enum MQTTConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}

/// Represents the current subscription state for one subscription
/// by the [MQTTProvider]
enum MqttSubscriptionState {
  IDLE,
  SUBSCRIBED
}