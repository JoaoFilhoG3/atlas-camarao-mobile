import 'package:atlas_do_camarao/model/route_api_model/coordinate.dart';

class Geometry {
  List<Coordinate>? coordinates;
  String? type;

  Geometry({this.coordinates, this.type});

  Geometry.fromJson(Map<String, dynamic> json) {
    if (json['coordinates'] != null) {
      coordinates = <Coordinate>[];
      json['coordinates'].forEach((v) {
        coordinates!.add(new Coordinate.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}
