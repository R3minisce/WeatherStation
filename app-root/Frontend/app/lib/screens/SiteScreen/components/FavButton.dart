import 'package:flutter/material.dart';

class FavButton extends StatelessWidget {
  final bool isFav;
  final VoidCallback toggleFavorite;

  FavButton(this.isFav, this.toggleFavorite);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      padding: EdgeInsets.all(0),
      alignment: Alignment.centerRight,
      icon: (isFav ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
      color: Colors.red[500],
      onPressed: this.toggleFavorite,
    );
  }
}