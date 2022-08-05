import 'package:app/providers.dart';
import 'package:app/screens/SiteScreen/strings.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef void StringCallback(String search);

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: defaultPadding * 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderSize * 5),
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
        child: TextField(
          style: textFieldStyle,
          onChanged: (String data) {
            context.read(searchProvider).state = data;
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(defaultPadding),
            hintText: hintText,
            suffixIcon: Icon(Icons.search, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
