import 'package:app/models/Site.dart';
import 'package:app/screens/SiteScreen/components/FavButton.dart';
import 'package:app/styles/style.dart';
import "package:flutter/material.dart";

class SiteRow extends StatelessWidget {
  final Site site;
  final VoidCallback toggleFavorite;
  SiteRow(this.site, this.toggleFavorite);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(borderSize),
            bottomLeft: Radius.circular(borderSize),
          ),
          color: primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(Icons.room_sharp, color: Colors.white),
                Text(site.nbRooms.toString())
              ],
            ),
            Text(site.name),
            FavButton(site.isFav, toggleFavorite)
          ],
        ),
      ),
    );
  }
}
