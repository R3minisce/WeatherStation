import 'dart:convert';
import 'dart:io';
import 'package:app/components/CustomText.dart';
import 'package:app/components/CustomTextInputField.dart';
import 'package:app/components/PageHeader.dart';
import 'package:app/models/Room.dart';
import 'package:app/screens/EditRoomScreen/components/Information.dart';
import 'package:app/screens/EditRoomScreen/components/ItemsSelector.dart';
import 'package:app/screens/EditRoomScreen/components/RoomHeader.dart';
import 'package:app/styles/style.dart';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class EditRoomUI extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final Room room;

  const EditRoomUI({Key key, this.formKey, this.room}) : super(key: key);

  @override
  _EditRoomUIState createState() => _EditRoomUIState();
}

class _EditRoomUIState extends State<EditRoomUI> {
  @override
  Widget build(BuildContext context) {
    bool isPic = (widget.room.picBytes != null);
    var decodePic = (isPic) ? base64.decode(widget.room.picBytes) : null;
    return Padding(
      padding: EdgeInsets.only(
        top: defaultPadding * 3,
        right: defaultPadding * 2,
        left: defaultPadding * 2,
      ),
      child: Column(
        children: [
          Row(children: [PageHeader("Edit room")]),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FormBuilder(
                    key: widget.formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: defaultPadding),
                        FormBuilderImagePicker(
                          name: "roomPicture",
                          initialValue: (isPic)
                              ? [
                                  MemoryFileSystem().file('temp')
                                    ..writeAsBytesSync(
                                      decodePic,
                                      mode: FileMode.writeOnly,
                                    )
                                ]
                              : [],
                          maxImages: 1,
                        ),
                        SizedBox(height: defaultPadding * 1.5),
                        RoomHeader(
                          formKey: widget.formKey,
                          room: widget.room,
                        ),
                        SizedBox(height: defaultPadding * 1.5),
                        Container(
                          width: double.infinity,
                          height: 90,
                          child: CustomInputTextField(
                            textFieldName: "roomDesc",
                            labelText: "Room Description",
                            initialValue: widget.room.desc,
                            isRequired: false,
                            maxChars: 100,
                          ),
                        ),
                        SizedBox(height: defaultPadding),
                        Row(
                          children: [
                            CustomText(label: "Select Sensors", fontSize: 22),
                            IconButton(
                              onPressed: () => showInfo(context),
                              icon: Icon(Icons.info_outlined, size: 24),
                            ),
                          ],
                        ),
                        ItemsSelector(
                            roomId: widget.room.id, formKey: widget.formKey),
                        SizedBox(height: defaultPadding),
                        Row(
                          children: [
                            CustomText(label: "Select Devices", fontSize: 22),
                          ],
                        ),
                        ItemsSelector(
                          roomId: widget.room.id,
                          formKey: widget.formKey,
                          isSensor: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
          title: const Text('Informations'),
          children: [
            Container(
              height: 100,
              width: 300,
              child: Information(),
            ),
          ],
        );
      },
    );
  }
}
