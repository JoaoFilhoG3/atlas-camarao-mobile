import 'package:atlas_do_camarao/util/permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MarkerLayerCurrentPosition extends StatefulWidget {
  LatLng? _currentPosition;
  MapController _mapController;

  MarkerLayerCurrentPosition(this._currentPosition, this._mapController, {super.key});

  @override
  State<MarkerLayerCurrentPosition> createState() => _MarkerLayerCurrentPositionState();
}

class _MarkerLayerCurrentPositionState extends State<MarkerLayerCurrentPosition> {
  bool hasTheMapZoomed = false;


  @override
  Widget build(BuildContext context) {
    //Verificando se a posição não é nula
    if (widget._currentPosition != null) {
      //Movendo a visualização do mapa para a posição atual
      //quando o mapa é iniciado
      if (!hasTheMapZoomed) {
        widget._mapController.move(widget._currentPosition!, 12);
        hasTheMapZoomed = true;
      }

      return MarkerLayer(markers: [
        Marker(
          point: widget._currentPosition!,
          child: Icon(
            Icons.location_history_rounded,
            color: Colors.blue,
            size: 40,
          ),
        ),
      ]);
    } else {
      //Caso a posição atual seja nula, retorna um MarkerLayer vazio
      return MarkerLayer(markers: []);
    }
  }
}
