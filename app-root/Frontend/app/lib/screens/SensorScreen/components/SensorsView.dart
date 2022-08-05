import 'package:app/components/CustomText.dart';
import 'package:app/models/Room.dart';
import 'package:app/models/Sensor.dart';
import 'package:app/models/SensorValue.dart';
import 'package:app/screens/SensorScreen/components/SensorCard.dart';
import 'package:app/services.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';

class SensorsView extends StatefulWidget {
  final Room room;
  final bool isSensor;

  const SensorsView({
    Key key,
    this.room,
    this.isSensor = true,
  }) : super(key: key);

  @override
  _SensorsViewState createState() => _SensorsViewState(room, isSensor);
}

class _SensorsViewState extends State<SensorsView> {
  List<dynamic> data = [];
  final Room room;
  final bool isSensor;

  _SensorsViewState(this.room, this.isSensor);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: isSensor ? fetchSensorsData() : getDevicesByRoomId(room.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("[ ERROR : SENSORSVIEW BUILDER ]");
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              data = snapshot.data;
              data.sort((a, b) => sortByFav(a, b));
              if (isSensor) {}
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.length > 0)
                    CustomText(
                      label: isSensor ? "Sensors :" : "Devices :",
                      fontSize: 24,
                    ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: defaultPadding,
                        mainAxisSpacing: defaultPadding,
                        childAspectRatio: 1.3),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          buildCard(data[i], i, isSensor),
                        ],
                      );
                    },
                  )
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Future<List<dynamic>> fetchSensorsData() async {
    List<Sensor> sensors = await getSensorByRoomId(room.id);
    for (Sensor s in sensors) {
      SensorValue value = await getLastValueOfSensor(s.id);
      s.lastValue = value.value;
    }
    return sensors;
  }

  Widget buildCard(var data, int i, bool isSensor) {
    return SensorCard(
        data, () => toggleFavorite(i), isSensor, () => toggleActivated(i));
  }

  int sortByFav(dynamic a, dynamic b) {
    return (a.isFav)
        ? (b.isFav)
            ? 0
            : -1
        : (b.isFav)
            ? 1
            : 0;
  }

  void toggleFavorite(int index) async {
    var item = data[index];
    item.isFav = !item.isFav;
    if (isSensor)
      await updateSensor(item);
    else
      await updateDevice(item);
    setState(() {});
  }

  void toggleActivated(int index) async {
    var item = data[index];
    item.activated = !item.activated;
    await updateDevice(item);
    setState(() {});
  }
}
