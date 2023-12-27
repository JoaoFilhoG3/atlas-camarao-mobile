import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CircleLayerRange extends StatefulWidget {
  LatLng? _currentPosition;
  double _range;

  CircleLayerRange(this._currentPosition, this._range, {super.key});

  @override
  State<CircleLayerRange> createState() => _CircleLayerRangeState();
}

class _CircleLayerRangeState extends State<CircleLayerRange> {
  @override
  Widget build(BuildContext context) {
    //Verificando se a posição não é nula
    if (widget._currentPosition != null) {
      return CircleLayer(
        circles: [
          CircleMarker(
            color: Colors.red.withOpacity(0.3),
            borderColor: Colors.red,
            borderStrokeWidth: 1,
            point: widget._currentPosition!,
            radius: widget._range * 1000,
            useRadiusInMeter: true,
          ),
        ],
      );
    }else{
      //Caso a posição atual seja nula, retorna um CircleLayer vazio
      return CircleLayer(circles: []);
    }

  }
}
