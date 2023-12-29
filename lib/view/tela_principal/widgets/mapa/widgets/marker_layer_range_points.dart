import 'package:atlas_do_camarao/api/features_api.dart';
import 'package:atlas_do_camarao/api/route_api.dart';
import 'package:atlas_do_camarao/model/feature.dart';
import 'package:atlas_do_camarao/model/route_api_model/travel.dart';
import 'package:atlas_do_camarao/util/consts.dart';
import 'package:atlas_do_camarao/util/custom_widgets.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/mapa/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MarkerLayerRangePoints extends StatefulWidget {
  Mapa _mapa;
  LatLng? _currentPosition;
  List<Feature> _lRangeFeatures = [];
  int _categoryIndex;
  double _range;

  MarkerLayerRangePoints(this._mapa, this._currentPosition, this._lRangeFeatures, this._categoryIndex, this._range, {super.key});

  @override
  State<MarkerLayerRangePoints> createState() => _MarkerLayerRangePointsState();
}

class _MarkerLayerRangePointsState extends State<MarkerLayerRangePoints> {
  List<double> lDistances = [];

  @override
  void didUpdateWidget(MarkerLayerRangePoints oldWidget) {
    if (widget._range > 0 && widget._currentPosition != null) {
      _loadRangeMarkers();
    }

    if (widget._range <= 0) {
      setState(() {
        widget._lRangeFeatures = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Verificando se a posição não é nula
    if (widget._currentPosition != null) {
      return FutureBuilder(
        future: _loadTravel(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.hasData && snapshot.data!.length > 0) {
              return MarkerLayer(
                markers: widget._lRangeFeatures.map((e) {
                  return Marker(
                    alignment: Alignment.center,
                    width: 100,
                    height: 70,
                    point: LatLng(
                      e.geometry!.coordinates![1],
                      e.geometry!.coordinates![0],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: EdgeInsets.only(top: 2, left: 5, bottom: 2, right: 5),
                            child: CustomWidgets.buildText(
                                (snapshot.data![widget._lRangeFeatures.indexOf(e)] / 1000).toStringAsFixed(2) + "Km",
                              CustomWidgets.textColorPrimary,
                              CustomWidgets.textBigger,
                              "Montserrat",
                            )),
                        Expanded(child: Consts.lImages[widget._categoryIndex - 1]),
                      ],
                    ),
                  );
                }).toList(),
              );
            }
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          return MarkerLayer(markers: []);
        },
      );
    } else {
      //Caso a posição atual seja nula, retorna um MarkerLayer vazio
      return MarkerLayer(markers: []);
    }
  }

  _loadRangeMarkers() async {
    List<Feature> lFeatures = await FeaturesApi.getFeatures(widget._currentPosition!, range: widget._range);

    lFeatures = lFeatures.where((element) => element.properties!.gidCategoria! == widget._categoryIndex).toList();

    setState(() {
      Consts.groupLayers.forEach((camada) {
        List<Map<String, dynamic>> groupLayers = camada["layers"] as List<Map<String, dynamic>>;
        groupLayers.forEach((layer) => layer["checked"] = false);
      });

      widget._lRangeFeatures = lFeatures;
      widget._mapa.loadLTravelsStream(lFeatures);
    });
  }

  Future<List<double>> _loadTravel() async {
    List<double> lDistances = [];
    for (int i = 0; i < widget._lRangeFeatures.length; i++) {
      Feature feature = widget._lRangeFeatures[i];
      Travel travel = await RouteApi.getRoute(widget._currentPosition!, LatLng(feature.geometry!.coordinates![1], feature.geometry!.coordinates![0]));
      double distance = travel.routes![0].distance!;
      lDistances.add(distance);
    }
    return lDistances;
  }
}
