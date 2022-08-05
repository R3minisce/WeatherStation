import 'dart:io';

import 'package:app/models/Room.dart';
import 'package:app/models/Site.dart';
import 'package:app/providers.dart';
import 'package:path/path.dart';
import 'package:app/screens/AddSiteScreen/components/AddSiteRoomRow.dart';
import 'package:app/services.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddSiteButton extends StatefulWidget {
  const AddSiteButton({
    Key key,
    @required this.formKey,
    this.isEditing = false,
    this.initialSite,
    this.initialRooms,
  }) : super(key: key);

  final GlobalKey<FormBuilderState> formKey;
  final bool isEditing;
  final Site initialSite;
  final List<Room> initialRooms;

  @override
  _AddSiteButtonState createState() => _AddSiteButtonState();
}

class _AddSiteButtonState extends State<AddSiteButton> {
  bool _inApiCall = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _inApiCall,
      child: Consumer(
        builder: (BuildContext context, watch, _) => Positioned(
          top: 3.5 * defaultPadding,
          right: 2 * defaultPadding,
          child: Container(
            width: 60,
            height: 60,
            child: IconButton(
              onPressed: () {
                widget.formKey.currentState.save();

                setState(() {
                  _inApiCall = true;
                });

                if (widget.formKey.currentState.validate()) {
                  List<AddSiteRoomRow> roomsWidgets =
                      watch(addSiteProvider).state.get();

                  Site site = widget.isEditing ? widget.initialSite : Site();

                  File image = getImage();

                  var imageBytes;
                  String picType;
                  if (image != null) {
                    imageBytes = image.readAsBytesSync();
                    picType = extension(image.path);
                  }

                  site.name = widget.formKey.currentState.value["siteName"];
                  site.picBytes = imageBytes;
                  site.picType = picType;

                  if (!widget.isEditing)
                    callAddSite(site, roomsWidgets, context);
                  else
                    callUpdateSite(site, roomsWidgets, context);

                  //
                } else {
                  print("[ ERROR : VALIDATION FAILED ]");
                  setState(() {
                    _inApiCall = false;
                  });
                }
              },
              icon: Icon(Icons.check, color: Colors.green, size: 35),
            ),
          ),
        ),
      ),
    );
  }

  void callAddSite(
      Site site, List<AddSiteRoomRow> roomsWidgets, BuildContext context) {
    var siteFuture = addSite(site);
    siteFuture.then((siteId) {
      roomsWidgets.forEach((element) {
        Room room = Room(
            name: widget.formKey.currentState.value["${element.id}"],
            siteId: siteId);
        var roomFuture = addRoom(room);
        roomFuture.then((value) {
          print("[ INFO : ROOM CREATED ]");
        });
      });
      setState(() {
        _inApiCall = false;
      });
      Navigator.of(context).pop(0);
    });
  }

  void callUpdateSite(
      Site site, List<AddSiteRoomRow> roomsWidgets, BuildContext context) {
    askConfirmation(context, roomsWidgets).then((confirmed) {
      if (confirmed) {
        var siteFuture = updateSite(site);
        siteFuture.then((value) {
          roomsWidgets.forEach((element) {
            if (element.realId != null) {
              Room room = widget.initialRooms
                  .firstWhere((element2) => element.realId == element2.id);

              if (widget.formKey.currentState.value["${element.id}"] == null) {
                var roomFuture = deleteRoom(room.id);
                roomFuture.then((value) {
                  print("[ INFO : ROOM DELETED ]");
                });
              } else {
                room.name = widget.formKey.currentState.value["${element.id}"];

                var roomFuture = updateRoom(room);
                roomFuture.then((value) {
                  print("[ INFO : ROOM UPDATED ]");
                });
              }
            } else {
              Room room = Room(
                  siteId: site.id,
                  name: widget.formKey.currentState.value["${element.id}"]);
              var roomFuture = addRoom(room);
              roomFuture.then((value) {
                print("[ INFO : ROOM ADDED ]");
              });
            }
          });

          setState(() {
            _inApiCall = false;
          });
          Navigator.of(context).pop(0);
        });
      } else {
        setState(() {
          _inApiCall = false;
        });
      }
    });
  }

  File getImage() {
    File image;
    if (widget.formKey.currentState.value["sitePicture"] != null &&
        !widget.formKey.currentState.value["sitePicture"].isEmpty)
      image = widget.formKey.currentState.value["sitePicture"][0] as File;
    return image;
  }

  Future<bool> askConfirmation(
      BuildContext context, List<AddSiteRoomRow> roomsWidgets) async {
    if (roomsWidgets.length <= widget.formKey.currentState.value.length - 2)
      return true;
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Some rooms are going to be removed. Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    bool confirmation = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

    return confirmation ?? false;
  }
}
