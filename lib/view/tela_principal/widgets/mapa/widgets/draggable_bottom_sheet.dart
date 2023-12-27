import 'package:atlas_do_camarao/model/feature.dart';
import 'package:atlas_do_camarao/model/route_api_model/travel.dart';
import 'package:atlas_do_camarao/util/consts.dart';
import 'package:atlas_do_camarao/util/custom_widgets.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/mapa/map.dart';
import 'package:flutter/material.dart';

class DraggableBottomSheet extends StatefulWidget {
  Mapa _mapa;
  List<Feature> _lFeatures = [];

  DraggableBottomSheet(this._mapa, this._lFeatures, {super.key});

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  @override
  Widget build(BuildContext context) {
    if (widget._lFeatures.length > 0) {
      return DraggableScrollableSheet(
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 60,
                          height: 3,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        IconButton(
                          onPressed: () {
                            widget._mapa.loadStream([]);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: widget._lFeatures.length,
                        itemBuilder: (context, index) {
                          //Viagem sendo percorrida
                          Feature feature = widget._lFeatures[index];
                          return ListTile(
                            leading: Consts.lImages[widget._lFeatures[index].properties!.gidCategoria! - 1],
                            title: CustomWidgets.buildText(
                              widget._lFeatures[index].properties!.nmFantasia! != ""
                                  ? widget._lFeatures[index].properties!.nmFantasia!
                                  : widget._lFeatures[index].properties!.rzSocial!,
                              CustomWidgets.textColorSecondary,
                              CustomWidgets.textMedium,
                              "Montserrat",
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.bold,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            subtitle: CustomWidgets.buildText(
                              widget._lFeatures[index].properties!.endereco!,
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

                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
