import 'package:app/models/Room.dart';
import 'package:app/screens/EditRoomScreen/components/EditRoomButton.dart';
import 'package:app/screens/EditRoomScreen/components/EditRoomUI.dart';
import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';


class EditRoomScreen extends StatefulWidget {
  const EditRoomScreen({
    Key key,
  }) : super(key: key);

  @override
  EditRoomScreenState createState() => new EditRoomScreenState();
}

class EditRoomScreenState extends State<EditRoomScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  Room room;

  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context).settings.arguments;
    imageCache.clear();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          EditRoomUI(formKey: formKey, room: room),
          EditRoomButton(formKey: formKey, initialRoom: room),
        ],
      ),
    );
  }
}