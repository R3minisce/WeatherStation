import 'dart:io';
import 'package:app/models/Device.dart';
import 'package:path/path.dart';
import 'package:app/models/Room.dart';
import 'package:app/models/Sensor.dart';
import 'package:app/services.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EditRoomButton extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final Room initialRoom;

  const EditRoomButton({Key key, this.formKey, this.initialRoom})
      : super(key: key);

  @override
  _EditRoomButtonState createState() => _EditRoomButtonState();
}

class _EditRoomButtonState extends State<EditRoomButton> {
  bool _inApiCall = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _inApiCall,
      child: Positioned(
        top: 2.5 * defaultPadding,
        right: 2 * defaultPadding,
        child: Container(
          width: 60,
          height: 60,
          child: IconButton(
            onPressed: () => validateForm(context),
            icon: Icon(Icons.check, color: Colors.green, size: 35),
          ),
        ),
      ),
    );
  }

  void validateForm(BuildContext context) {
    widget.formKey.currentState.save();

    setState(() {
      _inApiCall = true;
    });

    if (widget.formKey.currentState.validate()) {
      var values = widget.formKey.currentState.value;
      Room room = Room();
      File image = getImage();
      var imageBytes;
      String picType;
      if (image != null) {
        imageBytes = image.readAsBytesSync();
        picType = extension(image.path);
      }

      room.id = widget.initialRoom.id;
      room.isFav = widget.initialRoom.isFav;
      room.siteId = widget.initialRoom.siteId;
      room.picBytes = imageBytes;
      room.picType = picType;
      room.name = values['roomName'];
      room.desc = values['roomDesc'];
      room.icon = values['icon'];

      List<Sensor> sensors = castSensors(values['sensors']);
      List<Device> devices = castDevices(values['devices']);

      callUpdateRoom(room, context, sensors, devices);
    } else {
      print("[ ERROR : VALIDATION FAILED ]");
      setState(() {
        _inApiCall = false;
      });
    }
  }

  File getImage() {
    File image;
    if (widget.formKey.currentState.value["roomPicture"] != null &&
        !widget.formKey.currentState.value["roomPicture"].isEmpty)
      image = widget.formKey.currentState.value["roomPicture"][0] as File;
    return image;
  }

  List<Sensor> castSensors(List<dynamic> sensors) {
    List<Sensor> result = [];
    for (var s in sensors) {
      Sensor newSensor = Sensor();
      newSensor.cast(s);
      result.add(newSensor);
    }
    return result;
  }

  List<Device> castDevices(List<dynamic> devices) {
    List<Device> result = [];
    for (var d in devices) {
      Device newDevice = Device();
      newDevice.cast(d);
      result.add(newDevice);
    }
    return result;
  }

  void callUpdateRoom(Room room, BuildContext context,
      List<Sensor> selectedSensors, List<Device> selectedDevices) async {
    List<Sensor> initialSensors = await getSensorByRoomId(room.id);
    List<Device> initialDevices = await getDevicesByRoomId(room.id);

    bool confirmed = await askConfirmation(context, room, selectedSensors,
        initialSensors, selectedDevices, initialDevices);
    if (confirmed) {
      bool success = await updateRoom(room);
      if (success) {
        await updateItems(true, selectedSensors, initialSensors, room.id);
        await updateItems(false, selectedDevices, initialDevices, room.id);

        setState(() {
          _inApiCall = false;
        });
        Navigator.of(context).pop(0);
      }
    } else {
      setState(() {
        _inApiCall = false;
      });
    }
  }

  Future<bool> askConfirmation(
    BuildContext context,
    Room initialRoom,
    List<Sensor> selectedSensors,
    List<Sensor> initialSensors,
    List<Device> selectedDevices,
    List<Device> initialDevices,
  ) async {
    if (areAllItemsInitials(initialSensors, selectedSensors) &&
        areAllItemsInitials(initialDevices, selectedDevices)) return true;

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
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text(
          "Some sensors or devices are going to be removed. Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    bool confirmation = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

    return confirmation ?? false;
  }

  bool areAllItemsInitials(
      List<dynamic> initialItems, List<dynamic> selectedItems) {
    return initialItems.length ==
        selectedItems.where((element) => element.roomId != null).length;
  }

  updateItems(bool isSensor, List<dynamic> selectedItems,
      List<dynamic> initialItems, int id) {
    selectedItems.forEach((item) {
      if (item.roomId == null) {
        item.roomId = id;
        Future future = isSensor ? updateSensor(item) : updateDevice(item);
        future.then((value) {
          print("[ INFO : SENSOR / DEVICE UPDATED ]");
        });
      }
    });

    initialItems.forEach((item) {
      if (!selectedItems.any((element) => item.id == element.id)) {
        item.roomId = null;
        Future future = isSensor ? updateSensor(item) : updateDevice(item);
        future.then((value) {
          print("[ INFO : SENSOR / DEVICE UNLINKED ]");
        });
      }
    });
  }
}
