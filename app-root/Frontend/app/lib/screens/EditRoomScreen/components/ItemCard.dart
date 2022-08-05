import 'package:app/components/CustomText.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ItemCard extends StatefulWidget {
  final VoidCallback onTap;
  final item;
  final bool originallyLinked;
  final bool selected;
  final GlobalKey<FormBuilderState> formKey;
  final bool isSensor;

  const ItemCard({
    Key key,
    this.onTap,
    this.item,
    this.originallyLinked = false,
    this.selected = false,
    this.formKey,
    this.isSensor = true,
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderSize),
          color: primaryColor,
          boxShadow: [
            BoxShadow(
                color: roomColorDark,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(1.0, 1.0))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText(
                label: widget.isSensor ? widget.item.topic : widget.item.name,
                fontSize: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  label: widget.item.id.toString(),
                  fontSize: 20,
                ),
                if (widget.originallyLinked)
                  IconButton(
                      onPressed: null,
                      icon: widget.selected
                          ? Icon(Icons.link_rounded,
                              size: 28, color: Colors.green)
                          : Icon(Icons.link_off_rounded,
                              size: 28, color: Colors.red)),
                if (!widget.originallyLinked)
                  IconButton(
                    onPressed: null,
                    icon: widget.selected
                        ? Icon(Icons.check, size: 28, color: Colors.green)
                        : Icon(Icons.close_rounded,
                            size: 28, color: Colors.red),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
