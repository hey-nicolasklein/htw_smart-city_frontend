import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcity_frontend/models/MQTTProvider.dart';
import 'package:smartcity_frontend/screens/homeScreen/screens/topic_mqtt_view.dart';

/// This widget displays all topics that have received at least one MQTT-Message.
/// To gather them it uses the Cubit provided my the [MQTTProvider].
class AllMqttView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All MqttMessages', style: TextStyle(color: Colors.black)),
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellow,
      ),
      body: BlocBuilder<MqttCubits, Map<String, List<DatedString>>>(
        cubit: MQTTProvider().cubit,
        builder: (context, state) {
          return ListView(
            children: <Widget>[
              ...state.keys
                  .map((e) => Card(
                        child: ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TopicMqttView(
                                topic: e,
                              ),
                            ),
                          ),
                          title: Text(e),
                        ),
                      ))
                  .toList()
            ],
          );
        },
      ),
    );
  }
}
