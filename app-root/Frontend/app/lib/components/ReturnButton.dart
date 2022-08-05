import 'dart:math';

import 'package:flutter/material.dart';

class ReturnButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      child: Transform.rotate(
        angle: 180 * pi / 180,
        child: IconButton(
          alignment: Alignment.centerLeft,
          icon: Icon(Icons.double_arrow, size: 32),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ),
    );
  }
}