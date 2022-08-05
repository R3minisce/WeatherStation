import 'package:app/components/CustomText.dart';
import 'package:app/models/Room.dart';
import 'package:app/providers.dart';
import 'package:app/screens/AddSiteScreen/components/AddSiteRoomRow.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomSettings extends StatefulWidget {
  RoomSettings({
    Key key,
    this.formKey,
    this.initialRooms,
  }) : super(key: key);

  final GlobalKey<FormBuilderState> formKey;
  final List<Room> initialRooms;

  @override
  _RoomSettingsState createState() => _RoomSettingsState(formKey);
}

class _RoomSettingsState extends State<RoomSettings> {
  List<AddSiteRoomRow> rooms = [];
  int id = 0;

  final GlobalKey<FormBuilderState> formKey;

  _RoomSettingsState(this.formKey);

  @override
  Widget build(BuildContext context) {
    if (widget.initialRooms != null && rooms.isEmpty) initRooms(context);

    return Column(
      children: [
        Divider(thickness: 2),
        SizedBox(height: defaultPadding * 0.5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(label: "Room Settings", fontSize: 24, maxLines: 1),
            Container(
              width: 40,
              height: 40,
              child: IconButton(
                onPressed: () {
                  Key key = GlobalKey();
                  rooms.add(AddSiteRoomRow(
                      key: key,
                      id: id,
                      removeRoom: () => removeRoom(key, context)));
                  id++;
                  context.read(addSiteProvider).state.update(rooms);
                  setState(() {});
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            )
          ],
        ),
        ListView.builder(
          itemCount: rooms.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return rooms[index];
          },
        ),
      ],
    );
  }

  initRooms(BuildContext context) {
    widget.initialRooms.forEach((element) {
      Key key = GlobalKey();
      rooms.add(AddSiteRoomRow(
        key: key,
        id: id,
        initialValue: element.name,
        realId: element.id,
        removeRoom: () => removeRoom(key, context),
      ));
      id++;
    });
    context.read(addSiteProvider).state.update(rooms);
  }

  void removeRoom(Key key, BuildContext context) {
    AddSiteRoomRow room = rooms.firstWhere((element) => element.key == key);
    rooms.remove(room);
    context.read(addSiteProvider).state.update(rooms);
    setState(() {});
  }
}
