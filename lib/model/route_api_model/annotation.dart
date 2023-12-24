import 'package:atlas_do_camarao/model/route_api_model/metadata.dart';

class Annotation {
  Metadata? metadata;
  List<int>? datasources;
  List<double>? weight;
  List<int>? nodes;
  List<double>? distance;
  List<double>? duration;
  List<double>? speed;

  Annotation(
      {this.metadata,
      this.datasources,
      this.weight,
      this.nodes,
      this.distance,
      this.duration,
      this.speed});

  Annotation.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    datasources = json['datasources'].cast<int>();
    weight = json['weight'].cast<double>();
    nodes = json['nodes'].cast<int>();
    distance = json['distance'].cast<double>();
    duration = json['duration'].cast<double>();
    speed = json['speed'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    data['datasources'] = this.datasources;
    data['weight'] = this.weight;
    data['nodes'] = this.nodes;
    data['distance'] = this.distance;
    data['duration'] = this.duration;
    data['speed'] = this.speed;
    return data;
  }
}
