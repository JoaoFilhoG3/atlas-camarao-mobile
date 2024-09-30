import "dart:convert";

import "package:atlas_do_camarao/model/feature.dart";
import "package:atlas_do_camarao/util/prefs.dart";
import "package:http/http.dart" as http;
import "package:latlong2/latlong.dart";

class FeaturesApi {
  static Future<List<Feature>> getFeatures(LatLng latLng, {range = 3}) async {

    //Range recebido em quilômetros e convertido
    range = range / 100;
    List<Feature> lFeatures = [];

    try {
      var host = await Prefs.getString("HOST");
      var port = await Prefs.getString("PORT");
      var url = "http://$host:$port/geoserver/cite/ows"
          "?service=WFS"
          "&version=1.0.0"
          "&request=GetFeature"
          "&typeName=cite%3Aservico"
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
