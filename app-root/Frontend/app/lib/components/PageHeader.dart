import 'package:app/components/ReturnButton.dart';
import "package:flutter/material.dart";

class PageHeader extends StatelessWidget {
  final String title;
  PageHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ReturnButton(),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 22),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
