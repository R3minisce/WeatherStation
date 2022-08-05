import 'package:app/models/Device.dart';
import 'package:app/screens/ActionScreen/components/NothingRow.dart';
import 'package:app/services.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DeviceRow extends StatefulWidget {
  const DeviceRow({
    Key key,
    this.formKey,
    this.siteId,
  }) : super(key: key);
  final GlobalKey<FormBuilderState> formKey;
  final int siteId;

  @override
  _DeviceRowState createState() => _DeviceRowState();
}

class _DeviceRowState extends State<DeviceRow> {
  List<bool> states = [];
  @override
  Widget build(BuildContext context) {
    List<Device> devices;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FutureBuilder<List<Device>>(
          future: getDevicesBySiteId(widget.siteId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("[ ERROR : SENSORSVIEW BUILDER ]");
              return Container(
                width: 0.0,
                height: 0.0,
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              devices = snapshot.data;
              if (devices.isNotEmpty) {
                return Expanded(
                  child: Container(
                    height: 80,
                    child: FormBuilderField<dynamic>(
                      name: 'deviceChoice',
                      initialValue: null,
                      builder: (FormFieldState<dynamic> field) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: devices.length,
                            itemBuilder: (context, index) =>
                                getDevice(devices[index], index, field));
                      },
                    ),
                  ),
                );
              } else {
                return NothingRow();
              }
            }
          },
        ),
      ],
    );
  }

  Widget getDevice(Device device, int index, FormFieldState<dynamic> field) {
    states.add(false);
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: 140,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderSize),
        color: states[index] ? Colors.green : primaryColor,
        boxShadow: [
          BoxShadow(
            color: roomColorDark,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(1.0, 1.0),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          for (int i = 0; i < states.length; i++) {
            states[i] = false;
          }
          setState(() {
            states[index] = true;
          });
          field.didChange(device);
          widget.formKey.currentState.save();
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text(
              device.name,
              style: TextStyle(
                  color: states[index] ? Colors.black : Colors.white,
                  fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
