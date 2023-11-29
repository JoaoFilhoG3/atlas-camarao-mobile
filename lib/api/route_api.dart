import "dart:convert";

import "package:http/http.dart" as http;
import "package:latlong2/latlong.dart";

class RouteApi {
  static Future<List<LatLng>> getRoute(LatLng partida, LatLng destino) async {
    List<LatLng> lRoutes = [];

    try {
      var url = "http://router.project-osrm.org/route/v1/driving/"
          "${partida.longitude},${partida.latitude};"
          "${destino.longitude},${destino.latitude}"
          "?steps=true"
          "&annotations=true"
          "&geometries=geojson"
          "&overview=full";

      var response = await http.get(Uri.parse(url));

      Map<String, dynamic> fullResponse = json.decode(response.body);
      if (fullResponse["code"] == "Ok") {
        List responseAsList = fullResponse["routes"][0]["geometry"]["coordinates"];
        responseAsList.forEach((element) {
          LatLng latLng = LatLng(element[1], element[0]);
          lRoutes.add(latLng);
        });
      }
    } catch (erro) {
      print(erro);
    } finally {
      return lRoutes;
    }
  }
}
