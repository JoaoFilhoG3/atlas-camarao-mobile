import 'package:atlas_do_camarao/model/route_api_model/annotation.dart';
import 'package:atlas_do_camarao/model/route_api_model/step.dart';

class Leg {
  List<Step>? steps;
  String? summary;
  double? weight;
  double? duration;
  Annotation? annotation;
  double? distance;

  Leg(
      {this.steps,
      this.summary,
      this.weight,
      this.duration,
      this.annotation,
      this.distance});

  Leg.fromJson(Map<String, dynamic> json) {
    if (json['steps'] != null) {
      steps = <Step>[];
      json['steps'].forEach((v) {
        steps!.add(new Step.fromJson(v));
      });
    }
    summary = json['summary'];
    weight = double.parse(json['weight'].toString());
    duration = double.parse(json['duration'].toString());
    annotation = json['annotation'] != null
        ? new Annotation.fromJson(json['annotation'])
        : null;
    distance = double.parse(json['distance'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.toJson()).toList();
    }
    data['summary'] = this.summary;
    data['weight'] = this.weight;
    data['duration'] = this.duration;
    if (this.annotation != null) {
      data['annotation'] = this.annotation!.toJson();
    }
    data['distance'] = this.distance;
    return data;
  }
}
