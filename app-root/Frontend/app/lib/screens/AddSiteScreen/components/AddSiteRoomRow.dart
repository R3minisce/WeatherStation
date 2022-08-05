import 'package:app/components/CustomTextInputField.dart';
import 'package:app/styles/style.dart';
import 'package:app/utils.dart';
import 'package:flutter/material.dart';

class AddSiteRoomRow extends StatefulWidget {
  const AddSiteRoomRow({
    Key key,
    this.id,
    this.removeRoom,
    this.initialValue = "",
    this.realId,
  }) : super(key: key);

  final int id;
  final VoidCallback removeRoom;
  final String initialValue;
  final int realId;

  @override
  _AddSiteRoomRowState createState() => _AddSiteRoomRowState();
}

class _AddSiteRoomRowState extends State<AddSiteRoomRow> {
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    double menuWidth = 40;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width - 5 * defaultPadding - menuWidth,
            height: 70,
            child: CustomInputTextField(
              textFieldName: "${widget.id}",
              labelText: "Room name",
              initialValue: widget.initialValue,
              enabled: !isDisabled,
            ),
          ),
          SizedBox(width: defaultPadding),
          Container(
            width: menuWidth,
            height: 40,
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                isDisabled
                    ? Icons.settings_backup_restore_outlined
                    : Icons.delete,
                color: isDisabled ? Colors.grey : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  onPressed() {
    if (widget.realId != null) {
      setState(() {
        isDisabled = !isDisabled;
      });
    } else {
      widget.removeRoom();
    }
  }
}
