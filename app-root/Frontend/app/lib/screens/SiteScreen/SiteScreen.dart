import 'package:app/components/MenuIcon.dart';
import 'package:app/screens/SiteScreen/components/SiteView.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/SearchBar.dart';

class SiteScreen extends StatefulWidget {
  const SiteScreen({Key key}) : super(key: key);

  @override
  SiteScreenState createState() => new SiteScreenState();
}

class SiteScreenState extends State<SiteScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool _openedMenu = false;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, // Pour éviter les overflows en activant le clavier.
        body: Padding(
          padding: EdgeInsets.only(
              left: defaultPadding * 2,
              right: defaultPadding * 2,
              top: defaultPadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchBar(),
                  SizedBox(width: defaultPadding),
                  MenuIcon(
                    args: [
                      {'icon': Icons.add, 'action': add},
                      {'icon': Icons.edit, 'action': edit}
                    ],
                  ),
                ],
              ),
              Expanded(child: SiteView(openedMenu: _openedMenu)),
            ],
          ),
        ),
      ),
    );
  }

  void edit() {
    setState(() => _openedMenu = !_openedMenu);
  }

  void add() {
    Navigator.pushNamed(context, '/addSite').then((value) {
      if (value == 0) {
        final snackBar = SnackBar(
          backgroundColor: primaryColor,
          content: Text(
            'Yay! Site created!',
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setState(() {});
    });
  }
}
