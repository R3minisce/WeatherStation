import 'package:app/components/CustomText.dart';
import 'package:app/models/Sensor.dart';
import 'package:app/screens/SensorScreen/components/EventDialog.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';

class SensorCard extends StatelessWidget {
  final dynamic data;
  final VoidCallback toggleFavorite;
  final bool isSensor;
  final VoidCallback toggleActivated;
  SensorCard(
    this.data,
    this.toggleFavorite,
    this.isSensor,
    this.toggleActivated,
  );

  @override
  Widget build(BuildContext context) {
    String value = "";
    if (isSensor && data.lastValue != null && data.type == 'pourcent') {
      value = (data.lastValue * 100).toStringAsFixed(2) + '%';
    } else if (isSensor) value = data.lastValue.toString();
    return Expanded(
      child: InkWell(
        onTap:
            isSensor ? () => showSensorsDetails(context, data as Sensor) : null,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: defaultPadding * 0.5),
          width: double.infinity,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                label: isSensor ? data.topic : data.name,
                fontSize: 20,
              ),
              SizedBox(height: defaultPadding / 2),
              if (isSensor)
                CustomText(
                    label: data.lastValue != null ? value : "error",
                    fontSize: 20),
                if(!isSensor)
                CustomText(
                    label: "id: ${data.id}",
                    fontSize: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      iconSize: 24,
                      icon: (data.isFav
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border)),
                      color: Colors.red[500],
                      onPressed: toggleFavorite),
                  if (!isSensor)
                    IconButton(
                        iconSize: 24,
                        icon: Icon(Icons.radio_button_checked_sharp),
                        color: data.activated
                            ? Colors.green[500]
                            : Colors.red[500],
                        onPressed: toggleActivated),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSensorsDetails(BuildContext context, Sensor sensor) {
    showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return EventsDialog(sensor: sensor);
      },
    );
  }
}
