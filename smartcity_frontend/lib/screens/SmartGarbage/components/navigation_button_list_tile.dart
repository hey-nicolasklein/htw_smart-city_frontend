import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcity_frontend/models/constants.dart';
import 'package:smartcity_frontend/routes.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/components/button_list_tile.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/json/history.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/screens/list_screen.dart';

/// Navigates either either to a [ListScreen] containing the Sensor-History or
/// the Worker-History depending on [kind].
class NavigationListTile extends StatelessWidget {
  final ListType kind;

  const NavigationListTile({Key key, this.kind})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String type;

    if (kind == ListType.Worker) {
      icon = Icons.event;
      type = 'Worker';
    } else {
      icon = Icons.sort;
      type = 'Sensor';
    }

    return ButtonListTile(
      title: '$type History',
      icon: icon,
      subTitle: 'Display the full ${type.toLowerCase()} history',
      threeLine: false,
      callback: () => {
        Navigator.pushNamed(context, smartGarbageMainHistoryRoute,
            arguments: {'kind': kind})
      },
    );
  }
}
