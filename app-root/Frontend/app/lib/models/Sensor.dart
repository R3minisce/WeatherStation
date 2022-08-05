class Sensor {
  int id;
  String topic;
  bool isFav;
  int roomId;
  double lastValue;
  List<dynamic> sensorEvents;
  String type;

  Sensor(
      {this.id,
      this.topic,
      this.isFav,
      this.roomId,
      this.lastValue,
      this.sensorEvents,
      this.type});

  fromJson(dynamic o) {
    id = o['id'];
    topic = o['topic'];
    isFav = o['isFav'];
    roomId = o['roomId'];
    sensorEvents = o['sensorEvents'];
    type = o['type'];
  }

  cast(dynamic o) {
    id = o.id;
    topic = o.topic;
    isFav = o.isFav;
    roomId = o.roomId;
    sensorEvents = o.sensorEvents;
    lastValue = o.lastValue;
    type = o.type;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'topic': topic,
        'isFav': isFav,
        'roomId': roomId,
        'sensorEvents': sensorEvents,
        'type': type,
      };
}
