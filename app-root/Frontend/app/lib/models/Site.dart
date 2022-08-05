class Site {
  int id;
  String name;
  int nbRooms;
  bool isFav;
  var picBytes;
  String picType;

  Site({
    this.id,
    this.name,
    this.nbRooms,
    this.isFav,
    this.picBytes,
    this.picType,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'isFav': isFav,
        'picBytes': picBytes,
        'picType': picType,
      };

  fromJson(dynamic o) {
    id = o['id'];
    name = o['name'];
    nbRooms = o['nbRooms'];
    isFav = o['isFav'];
    picBytes = o['picBytes'];
    picType = o['picType'];
  }
}
