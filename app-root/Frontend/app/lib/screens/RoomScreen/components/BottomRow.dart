import 'package:app/components/CustomText.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';

class BottomRow extends StatelessWidget {
  final int nbSensors;
  final int nbDevices;
  BottomRow(this.nbSensors, this.nbDevices);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(nbSensors != 0)
            CustomText(
              label: "sensors : ${nbSensors.toString()}",
              fontSize: 14,
            ),
            if(nbSensors != 0)
            SizedBox(width: defaultPadding / 2),
            if(nbSensors != 0)
            Icon(
              Icons.circle,
              color: Colors.green,
              size: 16,
            ),
            if(nbSensors != 0)
            SizedBox(width: defaultPadding),
            if(nbDevices != 0)
            CustomText(
              label: "devices : ${nbDevices.toString()}",
              fontSize: 14,
            ),
            if(nbDevices != 0)
            SizedBox(width: defaultPadding / 2),
            if(nbDevices != 0)
            Icon(
              Icons.circle,
              color: Colors.green,
              size: 16,
            ),
          ],
        ),
      );
}