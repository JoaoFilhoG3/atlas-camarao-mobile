import 'package:atlas_do_camarao/api/features_api.dart';
import 'package:atlas_do_camarao/model/feature.dart';
import 'package:atlas_do_camarao/util/consts.dart';
import 'package:atlas_do_camarao/util/custom_widgets.dart';
import 'package:atlas_do_camarao/util/permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class Mapa extends StatefulWidget {
  Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  //Camadas e estilos
  List<String> _lLayers = [];
  List<String> _lStyles = [];

  //Marker de posição atual
  LatLng _currentPosition = LatLng(0, 0);
  bool _definedCurrentPosition = false;

  //Popup
  LatLng _popupPosition = LatLng(0, 0);
  bool _showPopup = false;
  List<Feature> _lFeatures = [];

  //Controller do mapa
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    //Carregando camadas
    _loadLayers();

    //Carregando posição do Usuário
    if (!_definedCurrentPosition) {
      _getCurrentPosition();
    }

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        onTap: (tapPosition, point) {
          FeaturesApi.getFeatures(point).then((lFeatures) {
            setState(() {
              this._lFeatures = lFeatures;
              _popupPosition = point;
              _showPopup = true;
            });
          });
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
        if (_lLayers.length > 0) ...[
          TileLayer(
            tileBounds: LatLngBounds(
              LatLng(-90, -180),
              LatLng(90, 180),
            ),
            wmsOptions: WMSTileLayerOptions(
              baseUrl: "http://192.168.0.17:8080/geoserver/cite/wms/?",
              layers: _lLayers,
              styles: _lStyles,
              format: "image/png",
              version: "1.1.1",
              transparent: true,
              uppercaseBoolValue: false,
            ),
          ),
        ],
        MarkerLayer(
          markers: [
            if (_definedCurrentPosition) ...[
              Marker(
                point: _currentPosition,
                child: Icon(
                  Icons.person_pin_circle_sharp,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
            ],
            //Verificando se deve mostrar ou não o Popup
            if (_showPopup) ...[
              if (_lFeatures.isEmpty) ...[
                Marker(
                  point: LatLng(
                    _popupPosition.latitude + 0.01,
                    _popupPosition.longitude,
                  ),
                  child: Container(
                    color: Colors.white,
                    child: CustomWidgets.buildText(
                        "Não foi possível",
                        CustomWidgets.textColorPrimary,
                        CustomWidgets.textBig,
                        "Montserrat"),
                  ),
                ),
              ] else ...[
                Marker(
                  height: 300,
                  width: 350,
                  point: LatLng(
                    _lFeatures[0].geometry!.coordinates![1] + 0.01,
                    _lFeatures[0].geometry!.coordinates![0],
                  ),
                  child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.blue,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomWidgets.buildText(
                                    "Pontos Próximos",
                                    Colors.white,
                                    CustomWidgets.textGiant,
                                    "Montserrat",
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _showPopup = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _lFeatures.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: CustomWidgets.textColorTerciary,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: CustomWidgets.buildText(
                                      _lFeatures[index].properties!.endereco ??
                                          "Endereço indisponível",
                                      CustomWidgets.textColorPrimary,
                                      CustomWidgets.textMedium,
                                      "Montserrat",
                                      textAlign: TextAlign.start,
                                    ),
                                    onTap: () {},
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ],
          ],
        ),
      ],
    );
  }

  /**
   * Método responsável por carregar as camadas que estão habilitadas
   */
  void _loadLayers() {
    _lLayers = [];
    _lStyles = [];
    Consts.groupLayers.forEach((camada) {
      List<Map<String, dynamic>> groupLayers =
          camada["layers"] as List<Map<String, dynamic>>;
      groupLayers.forEach((layer) {
        if (layer["checked"] as bool) {
          _lLayers.add(layer["name"]);
          _lStyles.add(layer["style"]);
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
        _definedCurrentPosition = true;
        mapController.move(_currentPosition, 12);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
