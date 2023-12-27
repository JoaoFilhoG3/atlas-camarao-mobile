import 'package:atlas_do_camarao/api/features_api.dart';
import 'package:atlas_do_camarao/api/route_api.dart';
import 'package:atlas_do_camarao/model/feature.dart';
import 'package:atlas_do_camarao/model/route_api_model/travel.dart';
import 'package:atlas_do_camarao/util/consts.dart';
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
      return MarkerLayer(
        markers: widget._lRangeFeatures.map((e) {
          return Marker(
            point: LatLng(
              e.geometry!.coordinates![1],
              e.geometry!.coordinates![0],
            ),
            child: Consts.lImages[widget._categoryIndex - 1],
          );
        }).toList(),
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
      widget._mapa.loadStream(lFeatures);
    });
  }
}
