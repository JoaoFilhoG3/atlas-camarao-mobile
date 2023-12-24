class Intersection {
  int? intersectionOut;
  List<bool>? entry;
  List<int>? bearings;
  List<double>? location;
  int? intersectionIn;

  Intersection(
      {this.intersectionOut,
      this.entry,
      this.bearings,
      this.location,
      this.intersectionIn});

  Intersection.fromJson(Map<String, dynamic> json) {
    intersectionOut = json['out'];
    entry = json['entry'].cast<bool>();
    bearings = json['bearings'].cast<int>();
    location = json['location'].cast<double>();
    intersectionIn = json['in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['out'] = this.intersectionOut;
    data['entry'] = this.entry;
    data['bearings'] = this.bearings;
    data['location'] = this.location;
    data['in'] = this.intersectionIn;
    return data;
  }
}
