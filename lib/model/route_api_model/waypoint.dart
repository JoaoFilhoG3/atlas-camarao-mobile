class Waypoint {
  String? hint;
  double? distance;
  String? name;
  List<double>? location;

  Waypoint({this.hint, this.distance, this.name, this.location});

  Waypoint.fromJson(Map<String, dynamic> json) {
    hint = json['hint'];
    distance = json['distance'];
    name = json['name'];
    location = json['location'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hint'] = this.hint;
    data['distance'] = this.distance;
    data['name'] = this.name;
    data['location'] = this.location;
    return data;
  }
}
