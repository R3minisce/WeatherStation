import 'dart:convert';
import 'dart:typed_data';
import 'package:app/models/Device.dart';
import 'package:app/models/Event.dart';
import 'package:app/models/Room.dart';
import 'package:app/models/Sensor.dart';
import 'package:app/models/SensorValue.dart';
import 'package:app/models/Site.dart';

import 'package:http/http.dart';

String apiIP = "192.168.0.171";
String apiPort = "9090";

//Sites Services

List<Site> parseSites(Uint8List responseBody) {
  List<Site> sites = [];
  final parsed =
      jsonDecode(utf8.decode(responseBody)).cast<Map<String, dynamic>>();

  parsed.forEach((site) {
    Site temp = Site();
    temp.fromJson(site);
    sites.add(temp);
  });
  return sites;
}

Future<List<Site>> getAllSites() async {
  var uri = new Uri.http("$apiIP:$apiPort", '/site');
  final response = await Client().get(uri);
  return parseSites(response.bodyBytes);
}

Future<Site> getOneSite(int id) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/site/$id');
  final response = await Client().get(uri);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  Site site = Site();
  site.fromJson(parsed);
  return site;
}

Future<bool> updateSite(Site site) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/site/${site.id}');
  final Response response = await put(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(site),
  );
  if (response.statusCode != 200) throw Exception(response.statusCode);
  return true;
}

Future<int> addSite(Site site) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/site');
  final Response response = await post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(site),
  );

  if (response.statusCode != 201) throw Exception(response.statusCode);

  String location = response.headers['location'];
  int index = location.lastIndexOf("/");
  return int.parse(location.substring(index + 1));
}

Future<bool> deleteSite(int id) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/site/$id');
  final Response response = await delete(
    uri,
  );
  if (response.statusCode != 200) throw Exception(response.statusCode);
  return true;
}

Future<int> addRoom(Room room) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/room');
  final Response response = await post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(room),
  );

  if (response.statusCode != 201) throw Exception(response.statusCode);

  String location = response.headers['location'];
  int index = location.lastIndexOf("/");
  return int.parse(location.substring(index + 1));
}

Future<bool> deleteRoom(int id) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/room/$id');
  final Response response = await delete(
    uri,
  );
  if (response.statusCode != 200) throw Exception(response.statusCode);
  return true;
}

//Rooms Services

Future<List<Room>> getAllRooms() async {
  var uri = new Uri.http("$apiIP:$apiPort", '/room');
  final response = await Client().get(uri);

  return parseRooms(response.bodyBytes);
}

Future<List<Room>> getRoomBySiteId(int id) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/site/$id/room');
  final response = await Client().get(uri);
  return parseRooms(response.bodyBytes);
}

List<Room> parseRooms(Uint8List responseBody) {
  List<Room> rooms = [];
  final parsed =
      jsonDecode(utf8.decode(responseBody)).cast<Map<String, dynamic>>();

  parsed.forEach((room) {
    Room temp = Room();
    temp.fromJson(room);
    rooms.add(temp);
  });
  return rooms;
}

Future<bool> updateRoom(Room room) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/room/${room.id}');

  final Response response = await put(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(room),
  );
  if (response.statusCode != 200) throw Exception(response.statusCode);
  return true;
}

//Sensors Services

Future<List<Sensor>> getAllSensors() async {
  var uri = new Uri.http("$apiIP:$apiPort", '/sensor');
  final response = await Client().get(uri);
  return parseSensors(response.bodyBytes);
}

Future<List<Sensor>> getUnassignedSensors() async {
  var uri = new Uri.http("$apiIP:$apiPort", '/sensor/unassigned');
  final response = await Client().get(uri);
  return parseSensors(response.bodyBytes);
}

Future<Sensor> getSensor(int id) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/sensor/$id');
  final response = await Client().get(uri);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  Sensor sensor = Sensor();
  sensor.fromJson(parsed);
  return sensor;
}

Future<List<Sensor>> getSensorByRoomId(int id) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/room/$id/sensor');
  final response = await Client().get(uri);
  return parseSensors(response.bodyBytes);
}

List<Sensor> parseSensors(Uint8List responseBody) {
  List<Sensor> sensors = [];
  final parsed =
      jsonDecode(utf8.decode(responseBody)).cast<Map<String, dynamic>>();

  parsed.forEach((sensor) {
    Sensor temp = Sensor();
    temp.fromJson(sensor);
    sensors.add(temp);
  });
  return sensors;
}

Future<SensorValue> getLastValueOfSensor(int id) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/sensor/$id/value');
  final response = await Client().get(uri);
  if (response.statusCode != 200) return SensorValue();
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  SensorValue value = SensorValue();
  value.fromJson(parsed);
  return value;
}

Future<bool> updateSensor(Sensor sensor) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/sensor/${sensor.id}');
  final Response response = await put(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(sensor),
  );
  if (response.statusCode != 200) throw Exception(response.statusCode);
  return true;
}

// Device Services

Future<List<Device>> getDevices() async {
  var uri = new Uri.http("$apiIP:$apiPort", '/device');
  final response = await Client().get(uri);
  return parseDevices(response.bodyBytes);
}

List<Device> parseDevices(Uint8List responseBody) {
  List<Device> devices = [];
  final parsed =
      jsonDecode(utf8.decode(responseBody)).cast<Map<String, dynamic>>();

  parsed.forEach((device) {
    Device temp = Device();
    temp.fromJson(device);
    devices.add(temp);
  });
  return devices;
}

Future<List<Device>> getDevicesByRoomId(int id) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/room/$id/device');
  final response = await Client().get(uri);
  return parseDevices(response.bodyBytes);
}

Future<List<Device>> getDevicesBySiteId(int id) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/site/$id/device');
  final response = await Client().get(uri);
  return parseDevices(response.bodyBytes);
}

Future<bool> updateDevice(Device device) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/device/${device.id}');
  final Response response = await put(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(device),
  );
  if (response.statusCode != 200) return false;
  return true;
}

Future<List<Device>> getUnassignedDevices() async {
  var uri = new Uri.http("$apiIP:$apiPort", '/device/unassigned');
  final response = await Client().get(uri);
  return parseDevices(response.bodyBytes);
}

// Events Services

Future<int> addEvent(Event event) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/event');
  final Response response = await post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(event),
  );

  if (response.statusCode != 201) throw Exception(response.statusCode);

  String location = response.headers['location'];
  int index = location.lastIndexOf("/");
  return int.parse(location.substring(index + 1));
}

Future<bool> deleteEvent(int id) async {
  var uri = new Uri.http("$apiIP:$apiPort", '/event/$id');
  final Response response = await delete(
    uri,
  );
  if (response.statusCode != 200) throw Exception(response.statusCode);
  return true;
}
