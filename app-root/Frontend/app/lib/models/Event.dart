class Event {
  int sensorId;
  int deviceId;
  double activationValue;
  bool triggerWhenHigher;
  bool deviceActivation;

  // in a parallel universe
  // bool activated;

  Event(
      {this.sensorId,
      this.deviceId,
      this.activationValue,
      this.triggerWhenHigher,
      this.deviceActivation});

  Map<String, dynamic> toJson() => {
        'sensorId': sensorId,
        'deviceId': deviceId,
        'activationValue': activationValue,
        'triggerWhenHigher': triggerWhenHigher,
        'deviceActivation': deviceActivation
      };

  fromJson(dynamic o) {
    sensorId = o['sensorId'];
    deviceId = o['deviceId'];
    activationValue = o['activationValue'];
    triggerWhenHigher = o['triggerWhenHigher'];
    deviceActivation = o['deviceActivation'];
  }
}
