import 'package:app/styles/style.dart';
import "package:flutter/material.dart";

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding * 2, vertical: defaultPadding),
      child: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: defaultPadding),
          width: 120,
          child: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: FittedBox(
              child: Icon(
                Icons.home_rounded,
                color: Colors.white,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: backgroundColorDark,
            shape: BoxShape.circle,
          ),
        ),
        Text("Home Keeper", style: titleStyle.copyWith(color: backgroundColorDark)),
        Text("by    eLITE", style: subtitleStyle.copyWith(color: backgroundColorDark)),
      ]),
    );
  }
}
