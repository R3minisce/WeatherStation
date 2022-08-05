import 'package:app/screens/EditRoomScreen/components/ItemCard.dart';
import 'package:app/services.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ItemsSelector extends StatefulWidget {
  const ItemsSelector(
      {Key key, this.roomId, this.formKey, this.isSensor = true})
      : super(key: key);

  final int roomId;
  final GlobalKey<FormBuilderState> formKey;
  final bool isSensor;

  @override
  _ItemsSelectorState createState() => _ItemsSelectorState();
}

class _ItemsSelectorState extends State<ItemsSelector> {
  List<dynamic> allItems = [];
  List<dynamic> unassignedItems = [];
  List<dynamic> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding, bottom: defaultPadding * 2),
      height: 140,
      child: FutureBuilder<List<dynamic>>(
        future: fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("[ ERROR : EDITIONSCREEN BUILDER ]");
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (allItems.isEmpty) {
              allItems.addAll(snapshot.data);
              selectedItems.addAll(snapshot.data);
              allItems.addAll(unassignedItems);
            }
            return FormBuilderField(
              initialValue: selectedItems,
              builder: (FormFieldState<dynamic> field) {
                if (allItems.length != 0)
                  return GridView.builder(
                    itemCount: allItems.length,
                    itemBuilder: (context, i) {
                      return ItemCard(
                        onTap: () => onTap(i, field),
                        item: allItems[i],
                        originallyLinked: allItems[i].roomId != null,
                        selected: selectedItems.contains(allItems[i]),
                        formKey: widget.formKey,
                        isSensor: widget.isSensor,
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      crossAxisCount: 1,
                      mainAxisSpacing: defaultPadding,
                      crossAxisSpacing: defaultPadding,
                    ),
                  );
                return Container();
              },
              name: widget.isSensor ? 'sensors' : 'devices',
            );
          }
        },
      ),
    );
  }

  void onTap(int index, FormFieldState<dynamic> field) {
    if (selectedItems.remove(allItems[index])) {
    } else {
      selectedItems.add(allItems[index]);
    }
    field.didChange(selectedItems);
    widget.formKey.currentState.save();
  }

  Future<List<dynamic>> fetchItems() async {
    List<dynamic> items = widget.isSensor
        ? await getUnassignedSensors()
        : await getUnassignedDevices();
    if (unassignedItems.isEmpty) unassignedItems.addAll(items);
    return widget.isSensor
        ? await getSensorByRoomId(widget.roomId)
        : await getDevicesByRoomId(widget.roomId);
  }
}
