import 'package:app/components/CustomNumberInputField.dart';
import 'package:app/components/CustomText.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ValueRow extends StatelessWidget {
  const ValueRow({
    Key key,
    this.formKey,
  }) : super(key: key);
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomText(label: "Activation value :", fontSize: 18),
        SizedBox(width: defaultPadding * 2),
        Expanded(
          child: Container(
            height: 55,
            child: CustomNumberInputField(
              labelText: "Value here",
              textFieldName: "ActivationValue",
            ),
          ),
        ),
      ],
    );
  }
}
