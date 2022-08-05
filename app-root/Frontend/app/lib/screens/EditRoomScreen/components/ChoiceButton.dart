import 'package:app/models/Room.dart';
import 'package:app/styles/style.dart';
import 'package:app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ChoiceButton extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final Room room;

  const ChoiceButton({Key key, this.formKey, this.room}) : super(key: key);

  @override
  _ChoiceButtonState createState() => _ChoiceButtonState();
}

class _ChoiceButtonState extends State<ChoiceButton> {
  String iconChoice;
  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      initialValue: widget.room.icon,
      builder: (FormFieldState<dynamic> field) {
        return Container(
          width: 40,
          height: 40,
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
          child: IconButton(
            onPressed: () async {
              iconChoice = await choseIcon(context);
              field.didChange(iconChoice);
              widget.formKey.currentState.save();
              setState(() {});
            },
            icon: (iconChoice == null)
                ? Icon(getIconFromString(widget.room.icon))
                : Icon(
                    getIconFromString(iconChoice),
                  ),
          ),
        );
      },
      name: 'icon',
    );
  }

  Future<String> choseIcon(BuildContext context) async {
    List<String> icons = [
      "restaurant",
      "king_bed",
      "deck",
      "car_repair",
      "event_seat",
      "gamepad",
      "hotel",
      "hottub", 
      "house"
    ];
    return await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: const Text('Select an icon'),
          children: [
            Container(
              height: 200,
              width: 200,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: icons.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      buildIcon(icons[i], context),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildIcon(String icon, BuildContext context) {
    return IconButton(
      icon: Icon(getIconFromString(icon)),
      onPressed: () {
        Navigator.pop(context, icon);
      },
    );
  }
}
