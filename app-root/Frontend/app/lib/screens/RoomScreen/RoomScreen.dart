import 'package:app/components/CustomText.dart';
import 'package:app/components/MenuIcon.dart';
import 'package:app/components/PageHeader.dart';
import 'package:app/components/PageIndicator.dart';
import 'package:app/models/Site.dart';
import 'package:app/styles/style.dart';
import "package:flutter/material.dart";
import "package:app/screens/SiteScreen/components/SiteTile.dart";
import 'components/RoomView.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key key}) : super(key: key);

  @override
  RoomScreenState createState() => new RoomScreenState();
}

class RoomScreenState extends State<RoomScreen> {
  PageController controller;

  bool _openedMenu = false;

  @override
  Widget build(BuildContext context) {
    RoomScreenArguments args = ModalRoute.of(context).settings.arguments;
    this.controller = PageController(initialPage: args.index);

    List<Site> sites = args.sites;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            children: getPages(sites),
            controller: controller,
          ),
          Positioned(
            left: defaultPadding * 2,
            top: defaultPadding * 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.popUntil(
                    context,
                    ModalRoute.withName("/sites"),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.home, size: 24),
                      SizedBox(width: defaultPadding),
                      CustomText(label: "HOMEKEEPER", fontSize: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: defaultPadding * 1.5,
            top: defaultPadding * 2.75,
            child: PageIndicator(controller, sites.length),
          )
        ],
      ),
    );
  }

// Functions

  List<Widget> getPages(List<Site> sites) {
    return List<Widget>.generate(
      sites.length,
      (index) {
        Site site = sites[index];
        return Padding(
          padding: EdgeInsets.only(
            right: defaultPadding * 2,
            left: defaultPadding * 2,
            top: defaultPadding * 5,
          ),
          child: Column(
            children: [
              SizedBox(height: defaultPadding),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PageHeader(site.name),
                    MenuIcon(
                      args: [
                        {'icon': Icons.edit, 'action': edit}
                      ],
                    ),
                  ]),
              SizedBox(height: defaultPadding),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: RoomView(
                      siteID: site.id,
                      picture: site.picBytes,
                      openedMenu: _openedMenu,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> refresh() async {
    setState(() {});
  }

  void edit() {
    setState(() => _openedMenu = !_openedMenu);
  }
}
