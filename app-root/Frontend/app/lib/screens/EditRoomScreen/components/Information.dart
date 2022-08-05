import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.link_rounded, size: 28, color: Colors.green)),
          Text("Linked")
        ]),
        Row(children: [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.link_off_rounded, size: 28, color: Colors.red)),
          Text("Unlinked")
        ]),
      ]),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.check, size: 28, color: Colors.green)),
          Text("Newly assigned")
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.close_rounded, size: 28, color: Colors.red)),
          Text("Unassigned")
        ]),
      ]),
    ]);
  }
}