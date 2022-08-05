import 'styles/style.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/homeScreen/HomeScreen.dart';
import 'package:app/screens/SiteScreen/SiteScreen.dart';
import 'package:app/screens/RoomScreen/RoomScreen.dart';
import 'package:app/screens/SensorScreen/SensorScreen.dart';
import 'package:app/screens/ActionScreen/ActionScreen.dart';
import 'package:app/screens/AddSiteScreen/AddSiteScreen.dart';
import 'package:app/screens/EditRoomScreen/EditRoomScreen.dart';

var routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/sites": (BuildContext context) => SiteScreen(),
  "/room": (BuildContext context) => RoomScreen(),
  "/sensor": (BuildContext context) => SensorScreen(),
  "/addSite": (BuildContext context) => AddSiteScreen(),
  "/editRoom": (BuildContext context) => EditRoomScreen(),
  "/addAction": (BuildContext context) => ActionScreen(),
};

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "The Home Keeper",
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColorDark,
        brightness: Brightness.dark,
        fontFamily: 'Lato',
      ),
      initialRoute: '/',
      routes: routes,
    ),
  );
}
