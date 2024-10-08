import 'dart:async';

import 'package:atlas_do_camarao/api/features_api.dart';
import 'package:atlas_do_camarao/model/feature.dart';
import 'package:atlas_do_camarao/model/route_api_model/travel.dart';
import 'package:atlas_do_camarao/util/consts.dart';
import 'package:atlas_do_camarao/util/permissions.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/mapa/widgets/circle_layer_range.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/mapa/widgets/draggable_bottom_sheet.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/mapa/widgets/marker_layer_current_position.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/mapa/widgets/marker_layer_popup.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/mapa/widgets/marker_layer_range_points.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/mapa/widgets/polyline_layer_routes.dart';
import 'package:atlas_do_camarao/view/tela_servico/tela_servico.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class Mapa extends StatefulWidget {
  late int _categoryIndex;
  late String _layer;
  late double _range;
  late String _host;
  late String _port;
  StreamController<List<Feature>> sclTravels = StreamController<List<Feature>>.broadcast();
  StreamController<int> scSelectedTravel = StreamController<int>.broadcast();
  StreamController<LatLng?> scPopupPosition = StreamController<LatLng?>.broadcast();

  Mapa(this._categoryIndex, this._layer, this._range, this._host, this._port, {super.key});

  @override
  State<Mapa> createState() => new _MapaState();

  loadLTravelsStream(List<Feature> lFeatures) {
    sclTravels.add(lFeatures);
  }

  loadSelectedTravelStream(int selectedTravel) {
    scSelectedTravel.add(selectedTravel);
  }

  loadPopupPositionStream(LatLng? popupPosition) {
    scPopupPosition.add(popupPosition);
  }

  double get range => _range;

  set range(double value) {
    _range = value;
  }
}

class _MapaState extends State<Mapa> {
  //Camadas e estilos
  List<String> _lLayers = [];
  List<String> _lStyles = [];

  //Marker de posição atua
  Future<LatLng?>? _currentPosition;

  //Features a serem apresentadas no Popup
  List<Feature> _lPopupFeatures = [];

  //Range
  List<Feature> _lRangeFeatures = [];

  LatLng partida = LatLng(0, 0);
  LatLng chegada = LatLng(0, 0);

  //Controller do mapa
  MapController _mapController = MapController();

  @override
  void initState() {
    _currentPosition = _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    //Carregando camadas
    _loadLayers();

    //Stack contendo o mapa e o DraggableScrollableSheet
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            onTap: (tapPosition, point) {
              FeaturesApi.getFeatures(point).then((lFeatures) {
                setState(() {
                  widget.loadPopupPositionStream(point);
                  _lPopupFeatures = lFeatures;
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
                  baseUrl: "http://${widget._host}:${widget._port}/geoserver/cite/wms/?",
                  layers: _lLayers,
                  styles: _lStyles,
                  format: "image/png",
                  version: "1.1.1",
                  transparent: true,
                  uppercaseBoolValue: false,
                ),
              ),
            ],
            //CircleLayerRange
            FutureBuilder(
              future: _currentPosition,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CircleLayerRange(snapshot.data, widget._range);
                } else {
                  return CircleLayer(circles: []);
                }
              },
            ),
            //PolylineLayerRoutes
            FutureBuilder(
              future: _currentPosition,
              builder: (futureContext, futureSnapshot) {
                if (futureSnapshot.hasData) {
                  return StreamBuilder<List<Feature>>(
                    initialData: [],
                    stream: widget.sclTravels.stream,
                    builder: (streamListTravelsContext, streamListTravelsSnapshot) {
                      if (streamListTravelsSnapshot.hasData) {
                        return StreamBuilder(
                          initialData: 0,
                          stream: widget.scSelectedTravel.stream,
                          builder: (streamSelectedTravelContext, streamSelectedTravelSnapshot) {
                            if (streamListTravelsSnapshot.hasData) {
                              return PolylineLayerRoutes(widget, futureSnapshot.data, streamListTravelsSnapshot.requireData, streamSelectedTravelSnapshot.requireData);
                            } else {
                              return MarkerLayer(markers: []);
                            }
                          },
                        );
                      } else {
                        return MarkerLayer(markers: []);
                      }
                    },
                  );
                } else {
                  return PolylineLayer(polylines: []);
                }
              },
            ),
            //MarkerLayerCurrentPosition
            FutureBuilder(
              future: _currentPosition,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MarkerLayerCurrentPosition(snapshot.data, _mapController);
                } else {
                  return MarkerLayer(markers: []);
                }
              },
            ),
            //MarkerLayerRangePoints
            FutureBuilder(
              future: _currentPosition,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MarkerLayerRangePoints(widget, snapshot.data, _lRangeFeatures, widget._categoryIndex, widget._range);
                } else {
                  return MarkerLayer(markers: []);
                }
              },
            ),
            //MarkerLayerPopup
            FutureBuilder(
              future: _currentPosition,
              builder: (futureContext, futureSnapshot) {
                if (futureSnapshot.hasData || futureSnapshot.data == null) {
                  return StreamBuilder<LatLng?>(
                    stream: widget.scPopupPosition.stream,
                    builder: (streamContext, streamSnapshot) {
                      if (streamSnapshot.hasData || streamSnapshot.data == null) {
                        return MarkerLayerPopup(widget, futureSnapshot.data, streamSnapshot.data, _lPopupFeatures);
                      } else {
                        return MarkerLayer(markers: []);
                      }
                    },
                  );
                } else {
                  return MarkerLayer(markers: []);
                }
              },
            ),
          ],
        ),
        StreamBuilder<List<Feature>>(
          initialData: [],
          stream: widget.sclTravels.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData || snapshot.data == null) {
              return DraggableBottomSheet(widget, snapshot.requireData);
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  /**
   *  Método responsável por retornar a posição atual do usuário.
   *  Caso a posição não seja encontrada ou caso não tenha a permissão
   * é retornado null.
   */
  Future<LatLng?> _getCurrentPosition() async {
    final hasPermission = await Permissions.handleLocationPermission(context);
    if (hasPermission) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).catchError((error) => print("Erro ao obter a localização do usuário: $error"));
      return LatLng(position.latitude, position.longitude);
    } else {
      return null;
    }
  }

  /**
   * Método responsável por carregar as camadas que estão habilitadas
   */
  void _loadLayers() {
    _lLayers = [];
    _lStyles = [];
    Consts.groupLayers.forEach((camada) {
      List<Map<String, dynamic>> groupLayers = camada["layers"] as List<Map<String, dynamic>>;
      groupLayers.forEach((layer) {
        if (layer["checked"] as bool) {
          _lLayers.add(layer["name"]);
          _lStyles.add(layer["style"]);
        }
      });
    });
  }
}
