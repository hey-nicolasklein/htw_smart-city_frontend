import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcity_frontend/main.dart';

///New Text Styles based on the system
///described in Refactoring UI by Steve Schoger

TextStyle getPrimaryTextStyle(Color color) {
  return GoogleFonts.openSans(
      fontWeight: FontWeight.w600, fontSize: 22, color: color);
}

TextStyle getSecondaryTextStyle(Color color) {
  return GoogleFonts.openSans(
      fontWeight: FontWeight.w600, fontSize: 20, color: color);
}

TextStyle getTeriaryTextStyle(Color color) {
  return GoogleFonts.openSans(
      fontWeight: FontWeight.w300, fontSize: 18, color: color);
}

TextStyle getPrimaryTextStyleSized(Color color, double size) {
  return GoogleFonts.openSans(
      fontWeight: FontWeight.w600, fontSize: size, color: color);
}

TextStyle getTeriaryTextStyleSized(Color color, double size) {
  return GoogleFonts.openSans(
      fontWeight: FontWeight.w300, fontSize: size, color: color);
}

/// AppTheme that is used in the [MaterialApp] placed in [MyApp]
ThemeData appTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    primaryColorDark: Colors.blueAccent,
    accentColor: Colors.amber,
    hintColor: Colors.white,
    dividerColor: Colors.white,
    buttonColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
  );
}


/// Old text styles used by a few parts of the app
const LargeTextSize = 26.0;
const MediumTextSize = 22.0;
const BodyTextSize = 16.0;
const TileHeaderTextSize = 20.0;
const TileSubHeaderTextSize = 15.0;

const HeadingTextStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: MediumTextSize,
  color: Colors.white,
);

const AppBarTextStyle = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: MediumTextSize,
  color: Colors.black,
);

const TitleTextStyle = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: LargeTextSize,
  color: Colors.black,
);

const Body1TextStyle = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: BodyTextSize,
  color: Colors.black,
);

const SubTitleTextStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 18,
  color: Colors.black,
);

const SubSubTitleTextStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 18,
  color: Colors.black,
);

const TileTextStyle = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: TileHeaderTextSize,
  color: Colors.blue,
);

const TileSubTextStyle = TextStyle(
  fontWeight: FontWeight.w200,
  fontSize: TileSubHeaderTextSize,
  color: Colors.blue,
);


