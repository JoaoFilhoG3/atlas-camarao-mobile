import "package:atlas_do_camarao/model/feature.dart";
import "package:atlas_do_camarao/util/consts.dart";
import "package:http/http.dart" as http;

class FeaturesApi{
  static Future<List<Feature>> getFeatures() async{
    var url = "http://localhost:8080/geoserver/cite/ows"
        "?service=WFS"
        "&version=1.0.0"
        "&request=GetFeature"
        "&typeName=cite%3Aservico"
        "&maxFeatures=50"
        "&outputFormat=application%2Fjson";
    return [];
  }
}