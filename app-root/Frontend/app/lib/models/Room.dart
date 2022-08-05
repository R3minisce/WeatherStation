class Room {
  int id;
  String name;
  String desc;
  String icon;
  bool isFav;
  var picBytes;
  String picType;
  int nbSensors;
  int nbDevices;
  bool isDescExpanded;
  int siteId;

  Room(
      {this.id,
      this.name,
      this.desc,
      this.icon,
      this.picBytes,
      this.picType,
      this.isFav,
      this.nbSensors,
      int nbDevices,
      this.isDescExpanded = false,
      this.siteId});

  fromJson(dynamic o) {
    id = o['id'];
    name = o['name'];
    desc = o['desc'];
    picBytes = o['picBytes'];
    picType = o['picType'];
    icon = o['icon'];
    isFav = o['isFav'];
    nbSensors = o['nbSensors'];
    nbDevices = o['nbDevices'];
    siteId = o['siteId'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'desc': desc,
        'picBytes': picBytes,
        'picType': picType,
        'icon': icon,
        'isFav': isFav,
        'siteId': siteId
      };
}
