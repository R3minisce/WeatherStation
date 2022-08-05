import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomNumberInputField extends StatelessWidget {
  final String textFieldName;
  final String labelText;
  final bool enabled;
  final int maxValue;
  final bool isRequired;

  const CustomNumberInputField({
    Key key,
    this.textFieldName,
    this.labelText,
    this.enabled = true,
    this.maxValue = 100,
    this.isRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: FormBuilderTextField(
        initialValue: '0',
        style: enabled
            ? textFieldStyle
            : textFieldStyle.copyWith(color: Colors.grey[800], fontSize: 12),
        name: textFieldName,
        enabled: enabled,
        decoration: InputDecoration(
          filled: false,
          labelText: labelText,
          border: OutlineInputBorder(),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 0.2, color: Colors.grey[800]),
          ),
        ),
        validator: FormBuilderValidators.compose(
          [
            if (isRequired)
              FormBuilderValidators.required(context,
                  errorText: "This field is required."),
            FormBuilderValidators.match(context, r'^\d+(\.\d{1,3})?$',
                errorText: "Bad pattern, entry should be decimal"),
            FormBuilderValidators.max(context, maxValue,
                errorText: "The maximum value is $maxValue"),
            FormBuilderValidators.min(context, 0,
                errorText: "The min value is 0"),
          ],
        ),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
