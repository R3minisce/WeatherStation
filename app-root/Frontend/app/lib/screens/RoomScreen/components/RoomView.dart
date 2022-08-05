import 'package:app/components/Picture.dart';
import 'package:app/models/Room.dart';
import 'package:app/services.dart';
import 'package:app/styles/style.dart';
import "package:flutter/material.dart";

import 'RoomTile.dart';

class RoomView extends StatefulWidget {
  const RoomView({
    Key key,
    @required this.siteID,
    @required this.picture,
    this.openedMenu,
  }) : super(key: key);

  final int siteID;
  final String picture;
  final bool openedMenu;

  @override
  RoomViewState createState() => new RoomViewState(siteID, picture);
}

class RoomViewState extends State<RoomView> {
  List<Room> allRooms;
  final int siteID;
  final String picture;

  RoomViewState(this.siteID, this.picture);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Picture(picture),
        SizedBox(height: defaultPadding),
        FutureBuilder<List<Room>>(
          future: getRoomBySiteId(this.siteID),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("[ ERROR : ROOMVIEW BUILDER ]");
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              this.allRooms = snapshot.data;
              this.allRooms.sort((a, b) => sortByFav(a, b));
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: this.allRooms.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      buildRow(this.allRooms[i], i),
                    ],
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }

  int sortByFav(Room a, Room b) {
    return (a.isFav)
        ? (b.isFav)
            ? 0
            : -1
        : (b.isFav)
            ? 1
            : 0;
  }

  Widget buildRow(Room room, int i) {
    return RoomTile(
      room,
      () => toggleFavorite(i),
      i,
      this.allRooms,
      widget.openedMenu,
      () => editRoom(i),
    );
  }

  void toggleFavorite(int index) {
    Room room = this.allRooms[index];
    room.isFav = !room.isFav;
    Future<bool> response = updateRoom(room);
    response.then((value) => setState(() {}));
  }

  void editRoom(int index) {
    Room room = allRooms[index];

    Navigator.pushNamed(context, '/editRoom', arguments: room).then((value) {
      if (value == 0) {
        final snackBar = SnackBar(
          backgroundColor: primaryColor,
          content: Text(
            'Yay! Room updated!',
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setState(() {});
    });
  }
}
