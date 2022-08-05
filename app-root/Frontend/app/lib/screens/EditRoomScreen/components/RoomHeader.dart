import 'package:app/components/CustomTextInputField.dart';
import 'package:app/models/Room.dart';
import 'package:app/screens/EditRoomScreen/components/ChoiceButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RoomHeader extends StatelessWidget {
  const RoomHeader({Key key, this.formKey, this.room}) : super(key: key);

  final GlobalKey<FormBuilderState> formKey;
  final Room room;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 280,
          height: 70,
          child: CustomInputTextField(
            textFieldName: "roomName",
            labelText: "Room name",
            initialValue: room.name,
          ),
        ),
        ChoiceButton(formKey: formKey, room: room),
      ],
    );
  }
}