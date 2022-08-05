class SensorValue {
  int id;
  double value;
  int sensorId;

  SensorValue({this.id, this.value, this.sensorId});

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
        'sensorId': sensorId,
      };

  fromJson(dynamic o) {
    id = o['id'];
    value = o['value'];
    sensorId = o['sensorId'];
  }
}
