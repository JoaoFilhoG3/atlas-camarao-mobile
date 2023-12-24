import 'package:atlas_do_camarao/model/route_api_model/geometry.dart';
import 'package:atlas_do_camarao/model/route_api_model/leg.dart';

class Route {
  Geometry? geometry;
  List<Leg>? legs;
  String? weightName;
  double? weight;
  double? duration;
  double? distance;

  Route(
      {this.geometry,
      this.legs,
      this.weightName,
      this.weight,
      this.duration,
      this.distance});

  Route.fromJson(Map<String, dynamic> json) {
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    if (json['legs'] != null) {
      legs = <Leg>[];
      json['legs'].forEach((v) {
        legs!.add(new Leg.fromJson(v));
      });
    }
    weightName = json['weight_name'];
    weight =   double.parse(json['weight'].toString());
    duration = double.parse(json['duration'].toString());
    distance = double.parse(json['distance'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    if (this.legs != null) {
      data['legs'] = this.legs!.map((v) => v.toJson()).toList();
    }
    data['weight_name'] = this.weightName;
    data['weight'] = this.weight;
    data['duration'] = this.duration;
    data['distance'] = this.distance;
    return data;
  }
}
