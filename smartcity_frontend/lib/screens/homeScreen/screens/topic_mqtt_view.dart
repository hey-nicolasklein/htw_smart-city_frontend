import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcity_frontend/models/MQTTProvider.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:smartcity_frontend/screens/homeScreen/screens/all_mqtt_view.dart';

/// Displays the recieved message on a specified topic. The widget [AllMqttView]
/// navigates to this widget, when a topic-tile is tapped.
/// Each message can be expanded to view the complete payload. The formatting
/// tries to be JSON friendly.
class TopicMqttView extends StatelessWidget {
  final String topic;

  const TopicMqttView({Key key, this.topic}) : super(key: key);

  ///Formats a string with JSON structure in mind.
  String prettify(String json_string) {
    var decoded = json.decode(json_string);
    return prettyJson(decoded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic, style: TextStyle(color: Colors.black), overflow: TextOverflow.fade,),
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellow,
      ),
      body: BlocBuilder<MqttCubits, Map<String, List<DatedString>>>(
        cubit: MQTTProvider().cubit,
        builder: (context, state) {
          return ListView(
            children: <Widget>[
              ...state[topic]
                      .map((e) => Card(
                              child: ExpansionTile(
                            title: Text(
                              e.message.substring(0, 30),
                            ),
                            subtitle: Text(e.time.toString()),
                            leading: Icon(Icons.import_contacts),
                                children: <Widget>[Text(prettify(e.message))],
                          )))
                      .toList() ??
                  []
            ],
          );
        },
      ),
    );
  }
}
