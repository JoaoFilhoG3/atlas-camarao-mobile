import 'package:atlas_do_camarao/model/route_api_model/geometry.dart';
import 'package:atlas_do_camarao/model/route_api_model/intersection.dart';
import 'package:atlas_do_camarao/model/route_api_model/maneuver.dart';

class Step {
  Geometry? geometry;
  Maneuver? maneuver;
  String? mode;
  String? ref;
  String? drivingSide;
  String? name;
  List<Intersection>? intersections;
  double? weight;
  double? duration;
  double? distance;

  Step(
      {this.geometry,
      this.maneuver,
      this.mode,
      this.ref,
      this.drivingSide,
      this.name,
      this.intersections,
      this.weight,
      this.duration,
      this.distance});

  Step.fromJson(Map<String, dynamic> json) {
    geometry = json['geometry'] != null ? new Geometry.fromJson(json['geometry']) : null;
    maneuver = json['maneuver'] != null ? new Maneuver.fromJson(json['maneuver']) : null;
    mode = json['mode'];
    ref = json['ref'];
    drivingSide = json['driving_side'];
    name = json['name'];
    if (json['intersections'] != null) {
      intersections = <Intersection>[];
      json['intersections'].forEach((v) {
        intersections!.add(new Intersection.fromJson(v));
      });
    }
    weight =   double.parse(json['weight'].toString());
    duration = double.parse(json['duration'].toString());
    distance = double.parse(json['distance'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    if (this.maneuver != null) {
      data['maneuver'] = this.maneuver!.toJson();
    }
    data['mode'] = this.mode;
    data['ref'] = this.ref;
    data['driving_side'] = this.drivingSide;
    data['name'] = this.name;
    if (this.intersections != null) {
      data['intersections'] = this.intersections!.map((v) => v.toJson()).toList();
    }
    data['weight'] = this.weight;
    data['duration'] = this.duration;
    data['distance'] = this.distance;
    return data;
  }
}
