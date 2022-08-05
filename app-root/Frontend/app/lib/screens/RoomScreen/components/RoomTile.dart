import 'package:app/models/Room.dart';
import 'package:app/screens/RoomScreen/components/BottomRow.dart';
import 'package:app/screens/RoomScreen/components/MidRow.dart';
import 'package:app/screens/RoomScreen/components/UpRow.dart';
import 'package:app/styles/style.dart';
import 'package:app/utils.dart';
import "package:flutter/material.dart";

class RoomTile extends StatefulWidget {
  final Room room;
  final int currentIndex;
  final List<Room> rooms;
  final bool openedMenu;
  final VoidCallback toggleFavorite;
  final VoidCallback editRoom;

  RoomTile(this.room, this.toggleFavorite, this.currentIndex, this.rooms,
      this.openedMenu, this.editRoom);

  @override
  _RoomTileState createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    double menuWidth = 40;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/sensor',
              arguments: SensorScreenArguments(
                  this.widget.rooms, this.widget.currentIndex),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            margin: EdgeInsets.only(bottom: defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderSize),
              color: primaryColor,
              boxShadow: [
                BoxShadow(
                  color: roomColorDark,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(1.0, 1.0), // shadow direction: bottom right
                )
              ],
            ),
            width: widget.openedMenu
                ? size.width - 4 * defaultPadding - menuWidth * 1.25
                : size.width - 4 * defaultPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                UpRow(widget.room.name, widget.room.icon),
                MidRow(
                    widget.room.desc ?? "",
                    widget.room.isFav,
                    widget.room.isDescExpanded,
                    toggleExpanded,
                    widget.toggleFavorite),
                  BottomRow(widget.room.nbSensors, widget.room.nbDevices),
              ],
            ),
          ),
        ),
        if (widget.openedMenu)
          Column(
            children: [
              Container(
                width: menuWidth,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderSize),
                  color: primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: roomColorDark,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(1.0, 1.0),
                    )
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.edit, size: 26),
                  color: Colors.white,
                  onPressed: widget.editRoom,
                ),
              ),
            ],
          )
      ],
    );
  }

  void toggleExpanded() {
    setState(
      () {
        widget.room.isDescExpanded = !widget.room.isDescExpanded;
      },
    );
  }
}

class SensorScreenArguments {
  List<Room> rooms;
  int index;

  SensorScreenArguments(List<Room> rooms, int index) {
    this.rooms = rooms;
    this.index = index;
  }
}
