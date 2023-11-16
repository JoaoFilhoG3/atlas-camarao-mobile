import 'package:atlas_do_camarao/util/consts.dart';
import 'package:atlas_do_camarao/util/custom_widgets.dart';
import 'package:atlas_do_camarao/util/permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/retry.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';

class Mapa extends StatefulWidget {
  Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  List<String> lLayers = [];
  List<String> lStyles = [];
  LatLng _currentPosition = LatLng(0, 0);
  LatLng _popupPosition = LatLng(0, 0);
  bool _showPopup = false;
  bool _definedLatLong = false;

  //Controller do mapa
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    //Carregando camadas
    _loadLayers();

    //Carregando posição do Usuário
    if (!_definedLatLong) {
      _getCurrentPosition();
    }

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        onTap: (tapPosition, point) {
          print("${point.latitude} | ${point.longitude}");
        },
        initialCenter: LatLng(
          -15,
          -53,
        ),
        initialZoom: 4,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        lLayers.length > 0
            ? TileLayer(
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
              )
            : SizedBox(),
        _definedLatLong
            ? MarkerLayer(
                markers: [
                  Marker(
                    point: _currentPosition,
                    child: Icon(
                      Icons.person_pin_circle_sharp,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                  Marker(
                      point: _currentPosition,
                      child: Container(
                        color: Colors.white,
                        child: CustomWidgets.buildText(
                            "oiiiii",
                            CustomWidgets.textColorPrimary,
                            CustomWidgets.textBig,
                            "Montserrat"),
                      ))
                ],
              )
            : SizedBox(),
      ],
    );
  }

  /**
   * Método responsável por carregar as camadas que estão habilitadas
   */
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

  /**
   * Método responsável por obter a posição atual do usuário
   */
  Future<void> _getCurrentPosition() async {
    final hasPermission = await Permissions.handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _definedLatLong = true;
        mapController.move(_currentPosition, 12);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
