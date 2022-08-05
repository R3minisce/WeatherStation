import 'package:app/components/CustomText.dart';
import 'package:app/components/MenuIcon.dart';
import 'package:app/components/PageHeader.dart';
import 'package:app/components/PageIndicator.dart';
import 'package:app/components/Picture.dart';
import 'package:app/models/Room.dart';
import 'package:app/screens/RoomScreen/components/RoomTile.dart';
import 'package:app/screens/SensorScreen/components/SensorInformations.dart';
import 'package:app/screens/SensorScreen/components/SensorsView.dart';
import 'package:app/styles/style.dart';
import "package:flutter/material.dart";

class SensorScreen extends StatefulWidget {
  const SensorScreen({Key key}) : super(key: key);

  @override
  SensorScreenState createState() => new SensorScreenState();
}

class SensorScreenState extends State<SensorScreen> {
  PageController controller;

  @override
  Widget build(BuildContext context) {
    SensorScreenArguments args = ModalRoute.of(context).settings.arguments;
    this.controller = PageController(initialPage: args.index);

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.hardEdge,
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            children: getPages(args),
            controller: controller,
          ),
          Positioned(
            left: defaultPadding * 2,
            top: defaultPadding * 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.popUntil(
                    context,
                    ModalRoute.withName("/sites"),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.home, size: 24),
                      SizedBox(width: defaultPadding),
                      CustomText(
                          label: args.rooms.length <= 5 ? "HOMEKEEPER" : "HK",
                          fontSize: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: defaultPadding * 1.5,
            top: defaultPadding * 2.75,
            child: PageIndicator(controller, args.rooms.length),
          )
        ],
      ),
    );
  }

  List<Widget> getPages(SensorScreenArguments args) {
    return List.generate(
      args.rooms.length,
      (index) {
        Room room = args.rooms[index];
        return Padding(
          padding: EdgeInsets.only(
            right: defaultPadding * 2,
            left: defaultPadding * 2,
            top: defaultPadding * 5,
          ),
          child: Column(
            children: [
              SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PageHeader(room.name),
                  IconButton(
                    onPressed: () => showInfo(context),
                    icon: Icon(Icons.info_outlined, size: 24),
                  ),
                  MenuIcon(
                    args: [
                      {
                        'icon': Icons.add_alarm,
                        'action':
                            room.nbSensors > 0 ? () => addEvent(room) : null,
                      }
                    ],
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Picture(room.picBytes),
                        if (room.nbSensors != 0)
                          SizedBox(height: defaultPadding * 2),
                        if (room.nbSensors != 0) SensorsView(room: room),
                        SizedBox(height: defaultPadding * 2),
                        SensorsView(room: room, isSensor: false),
                        SizedBox(height: defaultPadding * 2),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> refresh() async {
    setState(() {});
  }

  void addEvent(Room room) {
    Navigator.pushNamed(context, '/addAction', arguments: room).then((value) {
      if (value) {
        final snackBar = SnackBar(
          backgroundColor: primaryColor,
          content: Text(
            'Yay! Event created!',
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setState(() {});
    });
  }

  void showInfo(BuildContext context) {
    showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          title: Text('Informations'),
          children: [
            Container(
              height: 100,
              width: 250,
              child: SensorInformations(),
            ),
          ],
        );
      },
    );
  }
}
