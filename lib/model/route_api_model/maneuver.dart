class Maneuver {
  int? bearingAfter;
  int? bearingBefore;
  List<double>? location;
  String? type;
  String? modifier;

  Maneuver(
      {this.bearingAfter,
      this.bearingBefore,
      this.location,
      this.type,
      this.modifier});

  Maneuver.fromJson(Map<String, dynamic> json) {
    bearingAfter = json['bearing_after'];
    bearingBefore = json['bearing_before'];
    location = json['location'].cast<double>();
    type = json['type'];
    modifier = json['modifier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bearing_after'] = this.bearingAfter;
    data['bearing_before'] = this.bearingBefore;
    data['location'] = this.location;
    data['type'] = this.type;
    data['modifier'] = this.modifier;
    return data;
  }
}
