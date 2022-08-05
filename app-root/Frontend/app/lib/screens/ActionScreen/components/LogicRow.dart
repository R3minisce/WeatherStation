import 'package:app/components/CustomText.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LogicRow extends StatefulWidget {
  const LogicRow({
    Key key,
    this.formKey,
  }) : super(key: key);
  final GlobalKey<FormBuilderState> formKey;
  @override
  _LogicRowState createState() => _LogicRowState();
}

class _LogicRowState extends State<LogicRow> {
  bool more = false;
  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: 'logic',
      initialValue: more,
      builder: (FormFieldState<dynamic> field) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(label: "Activation logic :", fontSize: 18),
            SizedBox(width: defaultPadding),
            Container(
              margin: EdgeInsets.only(right: 20),
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderSize),
                color: !more ? Colors.green : primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: roomColorDark,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    more = false;
                  });
                  field.didChange(more);
                  widget.formKey.currentState.save();
                },
                child: Center(
                  child: Text(
                    "Less",
                    style: TextStyle(
                        color: !more ? Colors.black : Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderSize),
                color: more ? Colors.green : primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: roomColorDark,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    more = !more;
                  });
                  field.didChange(more);
                  widget.formKey.currentState.save();
                },
                child: Center(
                  child: Text(
                    "More",
                    style: TextStyle(
                        color: more ? Colors.black : Colors.white,
                        fontSize: 16),
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
