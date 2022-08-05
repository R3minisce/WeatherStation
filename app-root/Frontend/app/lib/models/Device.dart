class Device {
  int id;
  int roomId;
  bool isFav;
  String name;
  bool activated;

  Device({this.id, this.roomId, this.isFav, this.name, this.activated});

  Map<String, dynamic> toJson() => {
        'id': id,
        'roomId': roomId,
        'isFav': isFav,
        'name': name,
        'activated': activated
      };

  fromJson(dynamic o) {
    id = o['id'];
    roomId = o['roomId'];
    isFav = o['isFav'];
    name = o['name'];
    activated = o['activated'];
  }

  cast(dynamic o) {
    id = o.id;
    roomId = o.roomId;
    isFav = o.isFav;
    name = o.name;
    activated = o.activated;
  }
}
