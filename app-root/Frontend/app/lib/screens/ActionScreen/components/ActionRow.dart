import 'package:app/components/CustomText.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ActionRow extends StatefulWidget {
  const ActionRow({
    Key key,
    this.formKey,
  }) : super(key: key);
  final GlobalKey<FormBuilderState> formKey;

  @override
  _ActionRowState createState() => _ActionRowState();
}

class _ActionRowState extends State<ActionRow> {
  bool on = true;
  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: 'action',
      initialValue: on,
      builder: (FormFieldState<dynamic> field) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(label: "Action :", fontSize: 18),
            SizedBox(width: defaultPadding),
            Container(
              margin: EdgeInsets.only(right: defaultPadding),
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderSize),
                color: !on ? Colors.green : primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: roomColorDark,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(1.0, 1.0))
                ],
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    on = !on;
                  });
                  field.didChange(on);
                  widget.formKey.currentState.save();
                },
                child: Center(
                  child: Text(
                    "OFF",
                    style: TextStyle(
                        color: !on ? Colors.black : Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: defaultPadding),
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderSize),
                color: on ? Colors.green : primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: roomColorDark,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(1.0, 1.0))
                ],
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    on = !on;
                  });
                  field.didChange(on);
                  widget.formKey.currentState.save();
                },
                child: Center(
                  child: Text(
                    "ON",
                    style: TextStyle(
                        color: on ? Colors.black : Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
