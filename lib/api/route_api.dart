import "dart:convert";

import "package:atlas_do_camarao/model/route_api_model/travel.dart";
import "package:http/http.dart" as http;
import "package:latlong2/latlong.dart";

class RouteApi {
  static Future<Travel> getRoute(LatLng partida, LatLng destino) async {
    Travel travel = Travel();

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
      travel = Travel.fromJson(fullResponse);
    } catch (erro) {
      print(erro);
    } finally {
      return travel;
    }
  }
}
