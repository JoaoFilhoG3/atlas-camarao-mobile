import 'package:atlas_do_camarao/model/route_api_model/route.dart';
import 'package:atlas_do_camarao/model/route_api_model/waypoint.dart';

class Travel {
  String? code;
  List<Route>? routes;
  List<Waypoint>? waypoints;

  Travel({this.code, this.routes, this.waypoints});

  Travel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['routes'] != null) {
      routes = <Route>[];
      json['routes'].forEach((v) {
        routes!.add(new Route.fromJson(v));
      });
    }
    if (json['waypoints'] != null) {
      waypoints = <Waypoint>[];
      json['waypoints'].forEach((v) {
        waypoints!.add(new Waypoint.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.routes != null) {
      data['routes'] = this.routes!.map((v) => v.toJson()).toList();
    }
    if (this.waypoints != null) {
      data['waypoints'] = this.waypoints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}