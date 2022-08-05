import 'package:app/models/Room.dart';
import 'package:app/models/Sensor.dart';
import 'package:app/screens/ActionScreen/components/NothingRow.dart';
import 'package:app/services.dart';
import 'package:app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SensorRow extends StatefulWidget {

  const SensorRow({Key key, @required this.formKey}) : super(key: key);
  
  final GlobalKey<FormBuilderState> formKey;

  @override
  _SensorRowState createState() => _SensorRowState();
}

class _SensorRowState extends State<SensorRow> {
  List<bool> states = [];
  @override
  Widget build(BuildContext context) {
    Room args = ModalRoute.of(context).settings.arguments;
    int roomId = args.id;
    List<Sensor> sensors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FutureBuilder<List<Sensor>>(
          future: getSensorByRoomId(roomId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("[ ERROR : SENSORSVIEW BUILDER ]");
              return Container();
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              sensors = snapshot.data;
              if (sensors.isNotEmpty) {
                return Expanded(
                  child: Container(
                    height: 80,
                    child: FormBuilderField<dynamic>(
                      name: 'sensorChoice',
                      initialValue: sensors[0],
                      builder: (FormFieldState<dynamic> field) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sensors.length,
                            itemBuilder: (context, index) =>
                                getSensors(sensors[index], index, field));
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

  Widget getSensors(Sensor sensor, int index, FormFieldState<dynamic> field) {
    states.add(index == 0);
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
              offset: Offset(1.0, 1.0))
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
          field.didChange(sensor);
          widget.formKey.currentState.save();
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text(
              sensor.topic,
              textAlign: TextAlign.center,
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
