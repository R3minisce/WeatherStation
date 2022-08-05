import 'package:app/models/Device.dart';
import 'package:app/models/Event.dart';
import 'package:app/models/Sensor.dart';
import 'package:app/services.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ActionScreenButton extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;

  const ActionScreenButton({Key key, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 3.5 * defaultPadding,
      right: 2 * defaultPadding,
      child: IconButton(
        icon: Icon(Icons.check, color: Colors.green, size: 35),
        onPressed: () async {
          formKey.currentState.save();
          if (!formKey.currentState.value.containsKey('sensorChoice')) return;
          if (formKey.currentState.validate()) {
            await addEvent(parseEvent(formKey));
            Navigator.of(context).pop(true);
          }
        },
      ),
    );
  }

  Event parseEvent(GlobalKey<FormBuilderState> formKey) {
    Event event = Event();
    Sensor sensor = formKey.currentState.value['sensorChoice'];
    event.sensorId = sensor.id;
    Device device = formKey.currentState.value['deviceChoice'];

    event.deviceId = device != null ? device.id : null;

    if (sensor.type == 'bool') {
      if (double.parse(formKey.currentState.value['ActivationValue']) > 0) {
        event.activationValue = 1;
      } else {
        event.activationValue = 0;
      }
    } else if (sensor.type == 'pourcent') {
      event.activationValue =
          double.parse(formKey.currentState.value['ActivationValue']) / 100;
    } else {
      event.activationValue =
          double.parse(formKey.currentState.value['ActivationValue']);
    }

    event.triggerWhenHigher = formKey.currentState.value['logic'];
    event.deviceActivation = formKey.currentState.value['action'];

    return event;
  }
}
