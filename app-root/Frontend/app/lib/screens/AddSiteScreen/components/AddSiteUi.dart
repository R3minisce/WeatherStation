import 'dart:convert';
import 'package:app/screens/AddSiteScreen/components/RoomSettings.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:app/components/CustomTextInputField.dart';
import 'package:app/components/PageHeader.dart';
import 'package:app/models/Room.dart';
import 'package:app/models/Site.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class AddSiteUI extends StatelessWidget {
  const AddSiteUI({
    Key key,
    @required this.formKey,
    this.rooms,
    this.site,
  }) : super(key: key);

  final GlobalKey<FormBuilderState> formKey;
  final List<Room> rooms;
  final Site site;

  @override
  Widget build(BuildContext context) {
    imageCache.clear();
    bool isEditing = (site != null);
    bool isPic = (isEditing && site.picBytes != null);

    var decodePic = (isPic) ? base64.decode(site.picBytes) : null;
    return Padding(
      padding: EdgeInsets.only(
        top: defaultPadding * 3,
        right: defaultPadding * 2,
        left: defaultPadding * 2,
      ),
      child: Column(
        children: [
          SizedBox(height: defaultPadding),
          Row(children: [
            PageHeader(isEditing ? "Edit site" : "Add site"),
          ]),
          SizedBox(height: defaultPadding),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FormBuilder(
                    key: formKey,
                    skipDisabled: true,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FormBuilderImagePicker(
                          name: "sitePicture",
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
                        SizedBox(height: defaultPadding * 2),
                        Container(
                          width: double.infinity,
                          height: 70,
                          child: CustomInputTextField(
                              initialValue: isEditing ? site.name : null,
                              textFieldName: "siteName",
                              labelText: "Site name"),
                        ),
                        SizedBox(height: defaultPadding),
                        RoomSettings(formKey: formKey, initialRooms: rooms),
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
}
