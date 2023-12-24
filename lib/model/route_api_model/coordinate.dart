class Coordinate {
  double? lat;
  double? long;

  Coordinate({this.lat, this.long});

  Coordinate.fromJson(List<dynamic> latLng) {
    this.lat = latLng[1]??0.0;
    this.long = latLng[0]??0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
