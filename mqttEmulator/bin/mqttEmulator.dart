import 'package:mqttEmulator/mqttEmulator.dart';
import 'package:mqttEmulator/mqttProvider.dart';
// ignore: avoid_relative_lib_imports
// ignore: library_prefixes
// ignore: avoid_relative_lib_imports
import '../lib/constants.dart' as constants;

Future<void> main(List<String> arguments) async {
  var client = MQTTProvider();

  if (arguments.length != 1) {
    print(constants.WRONG_ARGUMENT);
  } else {
    switch (arguments[0]) {
      case 'backend':
        {
          await emulateBackendData(client);
          break;
        }
      case 'sensor':
        {
          await emulateSensorData(client);
          break;
        }
      case 'historyWorker':
        {
          await emulateWorkerHistoryExtended(client);
          break;
        }
      case 'historySensor':
        {
          await emulateSensorHistoryExtended(client);
          break;
        }
      default:
        print(constants.WRONG_ARGUMENT);
    }
  }
}
