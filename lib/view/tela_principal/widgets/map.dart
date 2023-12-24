import 'package:atlas_do_camarao/api/features_api.dart';
import 'package:atlas_do_camarao/api/route_api.dart';
import 'package:atlas_do_camarao/model/feature.dart';
import 'package:atlas_do_camarao/model/route_api_model/travel.dart';
import 'package:atlas_do_camarao/util/consts.dart';
import 'package:atlas_do_camarao/util/custom_widgets.dart';
import 'package:atlas_do_camarao/util/permissions.dart';
import 'package:atlas_do_camarao/view/tela_servico/tela_servico.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class Mapa extends StatefulWidget {
  late String _layer;
  late double _range;

  Mapa(this._layer, this._range, {super.key});

  @override
  State<Mapa> createState() => new _MapaState();
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
  List<Feature> _lPopupFeatures = [];

  //Range
  bool _showRange = false;
  List<Feature> _lRangeFeatures = [];

  //Vetor de Images para o Popup
  List<Widget> _lImages = [
    Image.asset(
      "assets/images/MarkerBlue.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerBrown.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerCyan.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerRed.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerYellow.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerPink.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerDeepOrange.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerPurple.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerTeal.png",
      width: 15,
    ),
  ];

  //Visualizando Rotas
  Travel travel = Travel();
  bool _showRoutes = false;
  LatLng partida = LatLng(0, 0);
  LatLng chegada = LatLng(0, 0);

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

    //Carregando rotas
    if (_showRoutes) {
      _loadRoutes();
    }

    //Carregando Markers no caso de um filtro estabelecido
    if (!_showRange) {
      _loadRangeMarkers();
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            onTap: (tapPosition, point) {
              FeaturesApi.getFeatures(point).then((lFeatures) {
                setState(() {
                  this._lPopupFeatures = lFeatures;
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
                  //otherParameters: {"cql_filter": "DWITHIN(geom,POINT(${_currentPosition.longitude} ${_currentPosition.latitude}),0.5,kilometers)"}
                ),
              ),
            ],
            MarkerLayer(
              markers: [
                //
                // Marcador de posição atual
                //
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
                //
                // Marcador de Popup
                //
                if (_showPopup) ...[
                  if (_lPopupFeatures.isEmpty) ...[
                    Marker(
                      point: LatLng(
                        _popupPosition.latitude + 0.01,
                        _popupPosition.longitude,
                      ),
                      child: Container(
                        color: Colors.white,
                        child: CustomWidgets.buildText("Não foi possível",
                            CustomWidgets.textColorPrimary, CustomWidgets.textBig, "Montserrat"),
                      ),
                    ),
                  ] else ...[
                    Marker(
                      height: 300,
                      width: 350,
                      point: LatLng(
                        _lPopupFeatures[0].geometry!.coordinates![1] + 0.01,
                        _lPopupFeatures[0].geometry!.coordinates![0],
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
                                  itemCount: _lPopupFeatures.length,
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
                                        leading: _lImages[
                                            _lPopupFeatures[index].properties!.gidCategoria! - 1],
                                        title: CustomWidgets.buildText(
                                          _lPopupFeatures[index].properties!.nmFantasia! != ""
                                              ? _lPopupFeatures[index].properties!.nmFantasia!
                                              : _lPopupFeatures[index].properties!.rzSocial!,
                                          CustomWidgets.textColorSecondary,
                                          CustomWidgets.textMedium,
                                          "Montserrat",
                                          textAlign: TextAlign.start,
                                          fontWeight: FontWeight.bold,
                                          textOverflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: CustomWidgets.buildText(
                                          _lPopupFeatures[index].properties!.endereco!,
                                          CustomWidgets.textColorTerciary,
                                          CustomWidgets.textSmall,
                                          "Montserrat",
                                          textAlign: TextAlign.start,
                                          textOverflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color: CustomWidgets.textColorPrimary,
                                        ),
                                        onTap: () {
                                          _callTelaServico(context, _lPopupFeatures[index]);
                                        },
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
            if (_showRoutes) ...[
              PolylineLayer(
                polylineCulling: false,
                polylines: [
                  Polyline(
                      points: travel.routes != null
                          ? travel.routes![0].geometry!.coordinates!
                              .map((e) => LatLng(e.lat!, e.long!))
                              .toList()
                          : [],
                      color: Colors.red.shade800,
                      strokeWidth: 5),
                ],
              )
            ],
            CircleLayer(
              circles: [
                CircleMarker(
                  color: Colors.red.withOpacity(0.3),
                  borderColor: Colors.red,
                  borderStrokeWidth: 1,
                  point: _currentPosition,
                  radius: widget._range * 1000,
                  useRadiusInMeter: true,
                ),
              ],
            ),
            if (_showRange) ...[
              MarkerLayer(
                  markers: _lRangeFeatures.map((e) {
                return Marker(
                  point: LatLng(
                    e.geometry!.coordinates![1],
                    e.geometry!.coordinates![0],
                  ),
                  child: Icon(
                    Icons.ac_unit,
                    color: Colors.blue,
                    size: 10,
                  ),
                );
              }).toList()),
            ],
          ],
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.1,
          minChildSize: 0.1,
          maxChildSize: 0.8,
          snap: true,
          snapSizes: [0.1, 0.8],
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 3,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ],
                      ),
                      Text("teste"),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  /**
   * Método responsável por carregar as rotas a serem mostradas no mapa
   */
  void _loadRoutes() async {
    travel = await RouteApi.getRoute(partida, chegada);
    setState(() {
      _showRoutes = true;
    });
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

  /**
   * Método responsável por chamar a tela de informações de um serviço e lidar com a resposta recebida
   */
  Future<void> _callTelaServico(BuildContext context, Feature feature) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaServico(feature)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    setState(() {
      Feature feature = result as Feature;

      _showRoutes = true;
      partida = _currentPosition;
      chegada = LatLng(feature.geometry!.coordinates![1], feature.geometry!.coordinates![0]);
    });
  }

  _loadRangeMarkers() async {
    if (widget._range > 0) {
      setState(() async {
        _lRangeFeatures =
            await FeaturesApi.getFeatures(_currentPosition, range: widget._range);
        _showRange = true;
      });
    }
  }
}
