import 'package:app/components/CustomText.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';

class EventRowHeader extends StatelessWidget {
  const EventRowHeader({Key key, this.topic}) : super(key: key);

  final String topic;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(label: '$topic details', fontSize: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(label: 'Device', fontSize: 16),
                CustomText(label: 'Value', fontSize: 16),
                CustomText(label: 'Mode', fontSize: 16),
                SizedBox(width: defaultPadding * 4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}