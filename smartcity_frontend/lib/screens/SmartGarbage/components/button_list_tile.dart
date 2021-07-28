import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/components/sensor_button_list_tile.dart';
import 'package:smartcity_frontend/screens/SmartGarbage/components/worker_button_list_tile.dart';
import 'package:smartcity_frontend/theme/style.dart';

/// Tappable tile that displays a icon, title and subTitle.
/// Essentially a wrapper around the [Card] and [ListTile] Widget
/// Is used by the [SensorButtonListTile] and [WorkerButtonListTile]
class ButtonListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final MaterialColor color;
  final bool threeLine;
  final VoidCallback callback;

  const ButtonListTile(
      {Key key, this.title, this.subTitle, this.icon, this.color, this.threeLine, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Card(
            color: Colors.white,
            elevation: 3,
            shadowColor: Colors.black38,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              isThreeLine: threeLine,
              leading: Icon(icon, size: 30, color: color),
              title: Text(
                title,
                textAlign: TextAlign.start,
                style: GoogleFonts.openSans(color: Colors.cyan.shade800),
              ),
              subtitle: Text(
                subTitle,
                textAlign: TextAlign.start,
                style: TileSubTextStyle,
              ),
              onTap: callback,
            )),
      ),
    );
  }
}
