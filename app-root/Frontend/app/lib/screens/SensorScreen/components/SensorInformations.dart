import 'package:flutter/material.dart';

class SensorInformations extends StatelessWidget {
  const SensorInformations({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.info, size: 28, color: Colors.white)),
          Text("All sensors are clickable")
        ]),
        Row(children: [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.radio_button_checked_sharp,
                  size: 28, color: Colors.green)),
          Text("/"),
          IconButton(
              onPressed: null,
              icon: Icon(Icons.radio_button_checked_sharp,
                  size: 28, color: Colors.red)),
          Text("Enabled / Disabled device")
        ]),
      ]),
    ]);
  }
}
