import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Size getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

Future<List> getSites() async {
  String jsonString = await rootBundle.loadString("data.json");
  List<dynamic> sites = jsonDecode(jsonString);
  return sites;
}

Future<List> getRooms() async {
  String jsonString = await rootBundle.loadString("site1.json");
  List<dynamic> rooms = jsonDecode(jsonString);
  return rooms;
}

Future<List> getSensors() async {
  String jsonString = await rootBundle.loadString("room1.json");
  List<dynamic> sensors = jsonDecode(jsonString);
  return sensors;
}

IconData getIconFromString(String name) {
  switch (name) {
    case 'restaurant':
      return Icons.restaurant;
    case "king_bed":
      return Icons.king_bed;
    case "car_repair":
      return Icons.car_repair;
    case "deck":
      return Icons.deck;
    case "event_seat":
      return Icons.event_seat_rounded;
    case "hotel":
      return Icons.hotel_rounded;
    case "hottub":
      return Icons.hot_tub_rounded;
    case 'gamepad':
      return Icons.gamepad;
    default:
      return Icons.house;
  }
}
