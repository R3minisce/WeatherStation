import 'dart:convert';

import 'package:app/models/Site.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';

class SitePic extends StatelessWidget {
  final Site site;
  SitePic(this.site);

  @override
  Widget build(BuildContext context) {
    var bytes;
    if (site.picBytes != null && site.picBytes is String)
      bytes = base64.decode(site.picBytes);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderSize),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: bytes != null
              ? MemoryImage(bytes)
              : AssetImage('images/placeholder.png'),
        ),
      ),
    );
  }
}
