import 'package:app/components/PageHeader.dart';
import 'package:app/models/Room.dart';
import 'package:app/screens/ActionScreen/components/ActionScreenButton.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'components/AddActionUI.dart';

class ActionScreen extends StatefulWidget {
  const ActionScreen({Key key}) : super(key: key);

  @override
  ActionScreenState createState() => new ActionScreenState();
}

class ActionScreenState extends State<ActionScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    Room room = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: defaultPadding * 3,
              right: defaultPadding * 2,
              left: defaultPadding * 2,
            ),
            child: Column(
              children: [
                SizedBox(height: defaultPadding),
                Row(children: [PageHeader("Add action")]),
                SizedBox(height: defaultPadding),
                Expanded(
                  child: Column(
                    children: [
                      AddActionUI(
                        formKey: formKey,
                        siteId: room.siteId,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ActionScreenButton(formKey: formKey),
        ],
      ),
    );
  }
}
