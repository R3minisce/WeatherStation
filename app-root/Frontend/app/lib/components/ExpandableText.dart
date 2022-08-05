import 'package:flutter/material.dart';

class ExpandableText extends StatelessWidget {
  final int lines;
  final String description;
  final bool isExpanded;
  ExpandableText(this.lines, this.description, this.isExpanded);

  @override
  Widget build(BuildContext context) => AnimatedDefaultTextStyle(
        child: Text(
          description,
          maxLines: isExpanded ? null : lines,
          overflow: isExpanded ? null : TextOverflow.ellipsis,
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: isExpanded ? 15 : 14,
        ),
        duration: Duration(milliseconds: 250),
      );
}
