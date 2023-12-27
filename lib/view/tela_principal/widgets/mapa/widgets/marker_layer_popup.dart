import 'package:atlas_do_camarao/api/route_api.dart';
import 'package:atlas_do_camarao/model/feature.dart';
import 'package:atlas_do_camarao/model/route_api_model/travel.dart';
import 'package:atlas_do_camarao/util/consts.dart';
import 'package:atlas_do_camarao/util/custom_widgets.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/mapa/map.dart';
import 'package:atlas_do_camarao/view/tela_servico/tela_servico.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MarkerLayerPopup extends StatefulWidget {
  //Instância da tela principal
  Mapa _mapa;

  //Popup
  LatLng? _currentPosition;
  LatLng? _popupPosition;
  List<Feature> _lPopupFeatures = [];

  MarkerLayerPopup(this._mapa, this._currentPosition, this._popupPosition, this._lPopupFeatures, {super.key});

  @override
  State<MarkerLayerPopup> createState() => _MarkerLayerPopupState();
}

class _MarkerLayerPopupState extends State<MarkerLayerPopup> {
  @override
  Widget build(BuildContext context) {
    //Verificando se a posição não é nula
    if (widget._popupPosition != null) {
      return MarkerLayer(
        markers: [
          if (widget._lPopupFeatures.isEmpty) ...[
            Marker(
              point: LatLng(
                widget._popupPosition!.latitude + 0.01,
                widget._popupPosition!.longitude,
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                color: Colors.white,
                child: CustomWidgets.buildText("Não foi possível encontrar pontos próximos.", CustomWidgets.textColorPrimary, CustomWidgets.textBig, "Montserrat"),
              ),
            ),
          ] else ...[
            Marker(
              height: 300,
              width: 350,
              point: LatLng(
                widget._lPopupFeatures[0].geometry!.coordinates![1] + 0.01,
                widget._lPopupFeatures[0].geometry!.coordinates![0],
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
                                    widget._popupPosition = null;
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
                          itemCount: widget._lPopupFeatures.length,
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
                                leading: Consts.lImages[widget._lPopupFeatures[index].properties!.gidCategoria! - 1],
                                title: CustomWidgets.buildText(
                                  widget._lPopupFeatures[index].properties!.nmFantasia! != ""
                                      ? widget._lPopupFeatures[index].properties!.nmFantasia!
                                      : widget._lPopupFeatures[index].properties!.rzSocial!,
                                  CustomWidgets.textColorSecondary,
                                  CustomWidgets.textMedium,
                                  "Montserrat",
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.bold,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                                subtitle: CustomWidgets.buildText(
                                  widget._lPopupFeatures[index].properties!.endereco!,
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
                                  _callTelaServico(context, widget._lPopupFeatures[index]);
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
      );
    } else {
      //Caso a posição atual seja nula, retorna um MarkerLayer vazio
      return MarkerLayer(markers: []);
    }
  }

  /**
   * Método responsável por chamar a tela de informações de um serviço e lidar com a resposta recebida
   */
  Future<void> _callTelaServico(BuildContext context, Feature feature) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaServico(feature)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    List<Travel> lTravelAux = [];
    if (widget._currentPosition != null) {
      Feature feature = result as Feature;
      widget._mapa.loadStream([feature]);
      widget._popupPosition = null;
      widget._lPopupFeatures = [];
    }
  }
}
