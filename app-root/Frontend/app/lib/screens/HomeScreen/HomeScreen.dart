import 'package:app/screens/HomeScreen/strings.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'components/FooterButton.dart';
import 'components/HomeBody.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(),
            HomeBody(),
            Column(
              children: [
                FooterButton(text: connectButton),
                FooterButton(text: subscribeButton),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
