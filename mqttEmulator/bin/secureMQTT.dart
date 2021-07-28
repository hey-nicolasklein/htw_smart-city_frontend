/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/010/2017
 * Copyright :  S.Hamblett
 *
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:typed_data/typed_data.dart' as typed;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/// An example of connecting to the google iot-core MQTT bridge server and publishing to a devices topic.
/// Full setup instructions can be found here https://cloud.google.com/iot/docs/how-tos/mqtt-bridge, please read this
/// before setting up and running this example.
Future<int> main() async {
  HttpOverrides.global = new MyHttpOverrides();

  // Create and connect the client
  const url = '134.96.216.46'; // The google iot-core MQTT bridge server
  const port = 8883; // You can also use 8883 if you so wish
  // The client id is a path to your device, example given below, note this contravenes the 23 character client id length
  // from the MQTT specification, the mqtt_client allows this, if exceeded and logging is turned on  a warning is given.
  const clientId = 'afdsasdfasdfasdfasdfasfsadf';
  // User name is not used and can be set to anything, it is needed because the password field contains the encoded JWT token for the device
  const username = 'Gruppe4';
  // Password contains the encoded JWT token, example below, the JWT token when generated should be encoded with the private key coresponding
  // to the public key you have set for your device.
  const password = 'm%hnEPu9HTfjV87';
  // Create the client
  final client = MqttServerClient(url, clientId);
  // Set the port
  client.port = port;
  // Set secure
  client.secure = true;
  // Set the security context as you need, note this is the standard Dart SecurityContext class.
  // If this is incorrect the TLS handshake will abort and a Handshake exception will be raised,
  // no connect ack message will be received and the broker will disconnect.
  //final currDir = '${path.current}${path.separator}';
  final context = SecurityContext.defaultContext;
  client.onBadCertificate = (dynamic a) => true;
  //final String fullPath = currDir + path.join('pem', 'truststore.pem');
  //context.useCertificateChain(fullPath);//client.crt
  //final File ye = File(fullPath);
  //Uint8List content = await ye.readAsBytes();
  //context.setTrustedCertificatesBytes(content);
  //context.setTrustedCertificates(fullPath);
  // If needed set the private key file path and the optional passphrase and any other supported security features
  // Note that for flutter users the parameters above can be set in byte format rather than file paths.
  client.securityContext = context;
  // Set the protocol to V3.1.1 for iot-core, if you fail to do this you will receive a connect ack with the response code
  // 0x01 Connection Refused, unacceptable protocol version
  client.setProtocolV311();
  // logging if you wish
  //client.logging(on: true);
  // OK, connect, if your encoded JWT token in the password field cannot be decoded by the corresponding public key attached
  // to the device or the JWT token is incorrect a connect ack message will be received with a return code of
  // 0x05 Connection Refused, not authorized. If the password field is not set at all the return code may be
  // 0x04 Connection Refused, bad user name or password
  await client.connect(username, password);
  if (client.connectionStatus.state == MqttConnectionState.connected) {
    print('iotcore client connected');
  } else {
    print(
        'ERROR iotcore client connection failed - disconnecting, state is ${client.connectionStatus.state}');
    client.disconnect();
  }
  // Troubleshooting tips can be found here https://cloud.google.com/iot/docs/troubleshooting
  // Publish to the topic you have associated with your device
  const topic = 'data/Gruppe4/test';
  // Use a raw buffer here, see MqttClientPayloadBuilder for payload building assistance.
  final buff = typed.Uint8Buffer(4);
  buff[0] = 'a'.codeUnitAt(0);
  buff[1] = 'b'.codeUnitAt(0);
  buff[2] = 'c'.codeUnitAt(0);
  buff[3] = 'd'.codeUnitAt(0);
  final builder = MqttClientPayloadBuilder();
  builder.addString('jooooo');
  client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload);
  print('Sleeping....');
  await MqttUtilities.asyncSleep(10);
  print('Disconnecting');
  client.disconnect();
  return 0;
}
