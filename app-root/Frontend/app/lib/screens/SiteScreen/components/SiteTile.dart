import 'package:app/models/Site.dart';
import 'package:app/styles/style.dart';
import 'package:app/utils.dart';
import "package:flutter/material.dart";

import 'SitePic.dart';
import 'SiteRow.dart';

class SiteTile extends StatefulWidget {
  final Site site;
  final int index;
  final List<Site> sites;
  final VoidCallback toggleFavorite;
  final VoidCallback delete;
  final VoidCallback update;
  final bool openedMenu;
  SiteTile(this.site, this.index, this.sites, this.toggleFavorite,
      this.openedMenu, this.delete, this.update);

  @override
  _SiteTileState createState() => _SiteTileState();
}

class _SiteTileState extends State<SiteTile> {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    double menuWidth = 40;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/room',
                arguments:
                    RoomScreenArguments(this.widget.sites, this.widget.index));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderSize),
              color: primaryColor,
              boxShadow: [
                BoxShadow(
                  color: roomColorDark,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(1.0, 1.0),
                )
              ],
            ),
            margin: EdgeInsets.only(bottom: defaultPadding * 2),
            height: 200,
            width: widget.openedMenu
                ? size.width - 4 * defaultPadding - menuWidth * 1.25
                : size.width - 4 * defaultPadding,
            child: Stack(
              children: [
                SitePic(widget.site),
                SiteRow(widget.site, widget.toggleFavorite),
              ],
            ),
          ),
        ),
        if (widget.openedMenu)
          Column(
            children: [
              Container(
                width: menuWidth,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderSize),
                  color: primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: roomColorDark,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(1.0, 1.0),
                    )
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.edit, size: 26),
                  color: Colors.white,
                  onPressed: widget.update,
                ),
              ),
              SizedBox(height: defaultPadding),
              Container(
                width: 40,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderSize),
                  color: primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: roomColorDark,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(1.0, 1.0),
                    )
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.delete, size: 26),
                  color: Colors.red,
                  onPressed: widget.delete,
                ),
              ),
            ],
          )
      ],
    );
  }
}

class RoomScreenArguments {
  List<Site> sites;
  int index;

  RoomScreenArguments(List<Site> sites, int index) {
    this.sites = sites;
    this.index = index;
  }
}
