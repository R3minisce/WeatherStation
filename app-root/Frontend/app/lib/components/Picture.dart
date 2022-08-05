import 'dart:convert';

import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';

class Picture extends StatelessWidget {
  final String picture;
  Picture(this.picture);

  @override
  Widget build(BuildContext context) {
    var bytes;
    if (picture != null) bytes = base64.decode(picture);
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderSize * 2),
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: bytes != null ? MemoryImage(bytes) : AssetImage('images/placeholder.png'),
        ),
      ),
    );
  }
}
