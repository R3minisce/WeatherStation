import 'package:app/models/Sensor.dart';
import 'package:app/screens/SensorScreen/components/EventRow.dart';
import 'package:app/services.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';

class EventRowBuilder extends StatefulWidget {
  final Sensor sensor;
  final VoidCallback updateDialog;
  const EventRowBuilder({
    Key key,
    this.sensor,
    this.updateDialog,
  }) : super(key: key);

  @override
  _EventRowBuilderState createState() => _EventRowBuilderState();
}

class _EventRowBuilderState extends State<EventRowBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(vertical: defaultPadding),
      height: 325,
      width: 300,
      child: ListView.builder(
        itemCount: widget.sensor.sensorEvents.length,
        itemBuilder: (context, index) {
          return EventRow(
            event: widget.sensor.sensorEvents[index],
            type: widget.sensor.type,
            handleDelete: () => handleDelete(index),
          );
        },
      ),
    );
  }

  handleDelete(int index) async {
    var element = widget.sensor.sensorEvents[index];
    await deleteEvent(element['id']);
    widget.updateDialog();
  }
}