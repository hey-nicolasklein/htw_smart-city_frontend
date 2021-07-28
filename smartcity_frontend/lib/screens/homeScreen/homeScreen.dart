import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcity_frontend/screens/homeScreen/screens/allservices_view.dart';
import 'package:smartcity_frontend/screens/homeScreen/screens/start_view.dart';

/// Renders the [StartView] as the HomeScreen of the app.
/// A [CurvedNavigationBar] gets attached to the bottom of the screen.
/// It can be used to navigate between the [StartView] and the [AllServicesView]
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          top: false,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: _getPage(_currentPage),
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          animationDuration: Duration(milliseconds: 200),
          items: <Widget>[
            Icon(
              Icons.home,
              size: 30,
            ),
            Icon(
              Icons.search,
              size: 30,
            ),
          ],
          onTap: (position) {
            setState(() {
              _currentPage = position;
            });
          },
        ));
  }

  /// Renders page depending on the page index.
  _getPage(int page) {
    switch (page) {
      case 0:
        return StartView();
      case 1:
        return AllServicesView();
    }
  }
}
