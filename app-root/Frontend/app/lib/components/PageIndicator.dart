import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  final PageController controller;
  final int length;
  PageIndicator(this.controller, this.length);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      height: 40,
      alignment: Alignment.bottomCenter,
      child: SmoothPageIndicator(
        controller: controller, // PageController
        count: length,
        effect: WormEffect(
          dotHeight: length > 10 ? 10 : 16,
          dotWidth: length > 10 ? 10 : 16,
          dotColor: backgroundColorLight,
          activeDotColor: backgroundColorLight,
          paintStyle: PaintingStyle.stroke,
          strokeWidth: 1.5,
        ),
        onDotClicked: (index) {
          controller.jumpToPage(index);
        },
      ),
    );
  }
}
