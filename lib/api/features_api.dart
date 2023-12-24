import "dart:convert";

import "package:atlas_do_camarao/model/feature.dart";
import "package:http/http.dart" as http;
import "package:latlong2/latlong.dart";

class FeaturesApi {
  static Future<List<Feature>> getFeatures(LatLng latLng, {range = 1}) async {

    //Range recebido em quilômetros e convertido
    range = range / 100;
    List<Feature> lFeatures = [];

    try {
      var url = "http://192.168.0.17:8080/geoserver/cite/ows"
          "?service=WFS"
          "&version=1.0.0"
          "&request=GetFeature"
          "&typeName=cite%3Aservico"
          "&maxFeatures=50"
          "&outputFormat=application%2Fjson"
          "&cql_filter=DWITHIN(geom,POINT(${latLng.longitude} ${latLng.latitude}),${range},kilometers)";

      var response = await http.get(Uri.parse(url));

      Map<String, dynamic> fullResponse = json.decode(response.body);
      List<dynamic> featureList = fullResponse["features"];
      featureList.forEach((feature) {
        lFeatures.add(Feature.fromJson(feature));
      });
      lFeatures.forEach((feature) {
        print(feature.toJson());
      });
    } catch (erro) {
      print(erro);
    } finally {
      return lFeatures;
    }
  }
}
