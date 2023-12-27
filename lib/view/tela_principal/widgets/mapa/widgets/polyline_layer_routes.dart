import 'package:atlas_do_camarao/api/route_api.dart';
import 'package:atlas_do_camarao/model/feature.dart';
import 'package:atlas_do_camarao/model/route_api_model/travel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PolylineLayerRoutes extends StatefulWidget {
  LatLng? _currentPosition;
  List<Feature> _lFeatures = [];

  PolylineLayerRoutes(this._currentPosition, this._lFeatures, {super.key});

  @override
  State<PolylineLayerRoutes> createState() => _PolylineLayerRoutesState();
}

class _PolylineLayerRoutesState extends State<PolylineLayerRoutes> {
  List<Travel> lTravels = [];

  @override
  void initState() {
    if (widget._currentPosition != null) {
      _getRoutes();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget._currentPosition != null && lTravels.isNotEmpty) {
      return PolylineLayer(
        polylineCulling: false,
        polylines: lTravels.map((travel) {
          return Polyline(
            points: travel.routes != null ? travel.routes![0].geometry!.coordinates!.map((e) => LatLng(e.lat!, e.long!)).toList() : [],
            color: Colors.red.shade800,
            strokeWidth: 5,
          );
        }).toList(),
      );
    } else {
      return PolylineLayer(polylines: []);
    }
  }

  _getRoutes() async {
    List<Travel> lTravelsAux = [];

    if (widget._lFeatures.isNotEmpty) {
      for (int i = 0; i < widget._lFeatures.length; i++) {
        Feature feature = widget._lFeatures[i];
        lTravelsAux.add(await RouteApi.getRoute(widget._currentPosition!, LatLng(feature.geometry!.coordinates![1], feature.geometry!.coordinates![0])));
      }
    }

    setState(() {
      lTravels = lTravelsAux;
    });
  }
}
