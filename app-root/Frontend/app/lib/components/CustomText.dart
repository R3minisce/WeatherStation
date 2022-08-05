import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key key,
    @required this.label,
    this.fontSize = 48,
    this.maxLines,
  }) : super(key: key);

  final String label;
  final double fontSize;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.caption.copyWith(
            color: Colors.white70,
            fontSize: fontSize,
          ),
    );
  }
}
