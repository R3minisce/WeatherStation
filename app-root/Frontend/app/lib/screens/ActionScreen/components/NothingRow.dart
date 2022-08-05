import 'package:app/components/CustomText.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';

class NothingRow extends StatelessWidget {
  const NothingRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderSize),
            color: Colors.redAccent,
          ),
          child: Center(
            child: CustomText(
              label: "Nothing To Show",
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}
