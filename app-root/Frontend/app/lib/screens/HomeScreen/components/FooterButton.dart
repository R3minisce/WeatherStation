import 'package:app/styles/style.dart';
import "package:flutter/material.dart";

class FooterButton extends StatelessWidget {
  final String text;

  FooterButton({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: defaultPadding / 2),
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10.0,
          primary: primaryColor, // background
          onPrimary: secondaryColor, // foreground
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderSize * 2),
          ),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/sites');
        },
        child: Text(
          text,
          style: buttonStyle,
        ),
      ),
    );
  }
}
