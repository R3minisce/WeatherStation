import 'package:app/components/CustomText.dart';
import 'package:app/screens/ActionScreen/components/ActionRow.dart';
import 'package:app/screens/ActionScreen/components/DeviceRow.dart';
import 'package:app/screens/ActionScreen/components/LogicRow.dart';
import 'package:app/screens/ActionScreen/components/SensorRow.dart';
import 'package:app/screens/ActionScreen/components/ValueRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddActionUI extends StatelessWidget {
  const AddActionUI({
    Key key,
    @required this.formKey,
    this.siteId,
  }) : super(key: key);

  final GlobalKey<FormBuilderState> formKey;
  final int siteId;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(label: "Select sensor :", fontSize: 18),
            SensorRow(
              formKey: formKey,
            ),
            LogicRow(formKey: formKey),
            ValueRow(
              formKey: formKey,
            ),
            Container(
              color: Colors.blueGrey[600],
              height: 0.5,
            ),
            CustomText(label: "Select device :", fontSize: 18),
            DeviceRow(formKey: formKey, siteId: siteId),
            ActionRow(formKey: formKey),
          ],
        ),
      ),
    );
  }
}
