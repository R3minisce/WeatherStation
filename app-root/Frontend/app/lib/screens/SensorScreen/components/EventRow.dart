import 'package:app/components/CustomText.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';

class EventRow extends StatelessWidget {
  final event;
  final VoidCallback handleDelete;
  final String type;

  const EventRow({Key key, this.event, this.handleDelete, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String deviceId = event['deviceId'].toString();
    var value = event['activationValue'];
    if (type == 'pourcent') value = (value * 100).toString() + '%';
    return Container(
      margin: EdgeInsets.only(bottom: defaultPadding),
      height: 60,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor,
        boxShadow: [
          BoxShadow(
            color: roomColorDark,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(1.0, 1.0),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomText(
              label: deviceId != 'null' ? deviceId : "None", fontSize: 24),
          Row(
            children: [
              CustomText(
                  label: event['triggerWhenHigher'] ? '>' : '<', fontSize: 24),
              CustomText(label: '$value', fontSize: 24),
            ],
          ),
          CustomText(
              label: event['deviceActivation'] ? 'on' : 'off', fontSize: 24),
          IconButton(
            icon: Icon(Icons.delete, size: 20, color: Colors.red),
            onPressed: handleDelete,
          )
        ],
      ),
    );
  }
}