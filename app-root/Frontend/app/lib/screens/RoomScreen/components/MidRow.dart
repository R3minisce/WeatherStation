import 'package:app/components/ExpandableText.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';

class MidRow extends StatelessWidget {
  final String description;
  final bool isFav;
  final bool isExpanded;
  final VoidCallback toggleExpanded;
  final VoidCallback toggleFavorite;
  MidRow(this.description, this.isFav, this.isExpanded, this.toggleExpanded,
      this.toggleFavorite);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: GestureDetector(
                onTap: toggleExpanded,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: defaultPadding),
                    child: ExpandableText(1, description, isExpanded)),
              ),
            ),
            IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.all(0),
                alignment: Alignment.centerRight,
                icon: (isFav
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border)),
                color: Colors.red[500],
                onPressed: toggleFavorite),
          ],
        ),
      );
}