import 'package:app/models/Room.dart';
import 'package:app/models/Site.dart';
import 'package:app/screens/AddSiteScreen/components/AddSiteUi.dart';
import 'package:app/screens/AddSiteScreen/components/AddSiteButton.dart';
import 'package:app/services.dart';
import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddSiteScreen extends StatefulWidget {
  const AddSiteScreen({Key key}) : super(key: key);

  @override
  AddSiteScreenState createState() => new AddSiteScreenState();
}

class AddSiteScreenState extends State<AddSiteScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Site site = ModalRoute.of(context).settings.arguments;
    bool isEditing = (site != null);

    if (isEditing)
      return ProviderScope(
        child: FutureBuilder(
          future: getRoomBySiteId(site.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("[ ERROR : ROOMVIEW BUILDER ]");
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              List<Room> rooms = snapshot.data;
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
                  children: [
                    AddSiteUI(
                      formKey: formKey,
                      rooms: rooms,
                      site: site,
                    ),
                    AddSiteButton(
                        formKey: formKey,
                        initialRooms: rooms,
                        initialSite: site,
                        isEditing: isEditing),
                  ],
                ),
              );
            }
          },
        ),
      );
    else {
      return ProviderScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              AddSiteUI(formKey: formKey, rooms: null, site: null),
              AddSiteButton(formKey: formKey, isEditing: isEditing),
            ],
          ),
        ),
      );
    }
  }
}