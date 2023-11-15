import 'package:atlas_do_camarao/util/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/retry.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';

class Mapa extends StatefulWidget {
  Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  List<String> lLayers=[];
  List<String> lStyles=[];

  void _loadLayers() {
    lLayers = [];
    lStyles = [];
    Consts.groupLayers.forEach((camada) {
      List<Map<String, dynamic>> groupLayers =
          camada["layers"] as List<Map<String, dynamic>>;
      groupLayers.forEach((layer) {
        if (layer["checked"] as bool) {
          lLayers.add(layer["name"]);
          lStyles.add(layer["style"]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadLayers();
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(0, 0),
        initialZoom: 1,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        lLayers.length>0?TileLayer(
          tileBounds: LatLngBounds(
            LatLng(-90, -180),
            LatLng(90, 180),
          ),
          wmsOptions: WMSTileLayerOptions(
            baseUrl: "http://192.168.0.17:8080/geoserver/cite/wms/?",
            layers: lLayers,
            styles: lStyles,
            format: "image/png",
            version: "1.1.1",
            transparent: true,
            uppercaseBoolValue: false,
          ),
        ):SizedBox(),
      ],
    );
  }
}
