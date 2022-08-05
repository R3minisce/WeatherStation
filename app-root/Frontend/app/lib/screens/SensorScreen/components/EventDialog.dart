import 'package:app/models/Sensor.dart';
import 'package:app/screens/SensorScreen/components/EventRowBuilder.dart';
import 'package:app/screens/SensorScreen/components/EventRowHeader.dart';
import 'package:app/services.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';

class EventsDialog extends StatefulWidget {
  const EventsDialog({
    Key key,
    this.sensor,
  }) : super(key: key);

  final Sensor sensor;

  @override
  _EventsDialogState createState() => _EventsDialogState();
}

class _EventsDialogState extends State<EventsDialog> {
  Sensor newSensor;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(defaultPadding),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      children: [
        EventRowHeader(topic: widget.sensor.topic),
        EventRowBuilder(
          sensor: newSensor ?? widget.sensor,
          updateDialog: getUpdatedSensor,
        ),
      ],
    );
  }

  getUpdatedSensor() async {
    newSensor = await getSensor(widget.sensor.id);
    setState(() {});
  }
}