import "package:atlas_do_camarao/model/feature.dart";
import "package:atlas_do_camarao/util/consts.dart";
import "package:http/http.dart" as http;
import "package:latlong2/latlong.dart";

class FeaturesApi{
  static Future<List<Feature>> getFeature(LatLng latLng) async{
    var url = "http://localhost:8080/geoserver/cite/ows"
        "?service=WFS"
        "&version=1.0.0"
        "&request=GetFeature"
        "&typeName=cite%3Aservico"
        "&maxFeatures=50"
        "&outputFormat=application%2Fjson"
        "&cql_filter=DWITHIN(geom,POINT(${latLng.longitude} ${latLng.latitude}),0.05,kilometers)";
    return [];
  }
}