import 'package:app/styles/style.dart';
import 'package:app/utils.dart';
import 'package:flutter/material.dart';

class UpRow extends StatelessWidget {
  final String name;
  final String icon;
  UpRow(this.name, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: roomStyle),
          Icon(
            getIconFromString(icon),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}