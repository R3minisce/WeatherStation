import 'package:app/models/Site.dart';
import 'package:app/services.dart';
import 'package:app/styles/style.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/providers.dart';
import 'SiteTile.dart';

class SiteView extends StatefulWidget {
  SiteView({Key key, this.openedMenu}) : super(key: key);

  final bool openedMenu;

  @override
  SiteViewState createState() => new SiteViewState();
}

class SiteViewState extends State<SiteView> {
  List<Site> allSites;
  List<Site> currentSites;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Site>>(
      future: getAllSites(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("[ ERROR : SITES FETCH ]");
        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          allSites = snapshot.data;
          return Consumer(builder: (context, watch, _) {
            final search = watch(searchProvider).state.toLowerCase();
            currentSites = allSites
                .where((site) => site.name.toLowerCase().contains(search))
                .toList();
            currentSites.sort((a, b) => sortByFav(a, b));
            return RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: currentSites.length,
                itemBuilder: (context, i) {
                  return Column(children: [buildRow(i)]);
                },
              ),
            );
          });
        }
      },
    );
  }

  Future<void> refresh() async {
    setState(() {});
  }

  int sortByFav(Site a, Site b) {
    return (a.isFav)
        ? (b.isFav)
            ? 0
            : -1
        : (b.isFav)
            ? 1
            : 0;
  }

  Widget buildRow(int i) {
    return SiteTile(
      currentSites[i],
      i,
      currentSites,
      () => toggleFavorite(i),
      widget.openedMenu,
      () => delete(i),
      () => update(i),
    );
  }

  void toggleFavorite(int index) {
    Site site = currentSites[index];
    site.isFav = !site.isFav;
    Future<bool> response = updateSite(site);
    response.then((value) => setState(() {}));
  }

  void delete(int index) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Are you sure you want to delete this site?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    Future<bool> confirmation = showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    confirmation.then((value) {
      if (value != null && value) {
        Site site = currentSites[index];
        Future future = deleteSite(site.id);
        future.then((value) => setState(() {}));
      }
    });
  }

  void update(int index) {
    Navigator.pushNamed(context, '/addSite', arguments: currentSites[index])
        .then((value) {
      if (value == 0) {
        final snackBar = SnackBar(
          backgroundColor: primaryColor,
          content: Text(
            'Yay! Site edited!',
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setState(() {});
    });
  }
}
