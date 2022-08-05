import 'package:flutter/material.dart';

class MenuIcon extends StatefulWidget {
  const MenuIcon({Key key, this.args}) : super(key: key);

  @override
  _MenuIconState createState() => _MenuIconState();

  final List<dynamic> args;
}

class _MenuIconState extends State<MenuIcon> {
  bool _opened = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: getMenu(),
    );
  }

  List<Widget> getMenu() {
    List<Widget> options = [];
    options = List<Widget>.generate(
      widget.args.length,
      (index) {
        if (_opened)
          return Container(
            width: 50,
            height: 50,
            child: IconButton(
              icon: Icon(widget.args[index]['icon'], size: 36),
              color: Colors.white,
              onPressed: widget.args[index]['action'],
            ),
          );
        return Container();
      },
    );

    options.add(
      Container(
        width: 50,
        height: 50,
        child: IconButton(
          icon: Icon(
            _opened ? Icons.close : Icons.menu,
            size: 36,
          ),
          color: Colors.white,
          onPressed: () {
            setState(
              () {
                _opened = !_opened;
              },
            );
          },
        ),
      ),
    );
    return options;
  }
}
