import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomInputTextField extends StatelessWidget {
  final String textFieldName;
  final String labelText;
  final String initialValue;
  final bool enabled;
  final int maxChars;
  final bool isRequired;

  const CustomInputTextField({
    Key key,
    this.textFieldName,
    this.labelText,
    this.initialValue = "",
    this.enabled = true,
    this.maxChars = 25,
    this.isRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesc = maxChars > 25;
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: FormBuilderTextField(
        initialValue: initialValue,
        maxLines: isDesc ? null : 1,
        minLines: null,
        expands: false,
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
            FormBuilderValidators.maxLength(context, maxChars,
                errorText: "This field is too long ($maxChars max)."),
          ],
        ),
        textInputAction: TextInputAction.done,
        keyboardType: isDesc ? TextInputType.multiline : TextInputType.text,
      ),
    );
  }
}
