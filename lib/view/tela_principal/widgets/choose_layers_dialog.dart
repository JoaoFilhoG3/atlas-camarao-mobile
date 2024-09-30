import 'package:atlas_do_camarao/util/custom_widgets.dart';
import 'package:atlas_do_camarao/util/consts.dart';
import 'package:flutter/material.dart';

class ChooseLayersDialog extends StatefulWidget {
  const ChooseLayersDialog({super.key});

  @override
  State<ChooseLayersDialog> createState() => _ChooseLayersDialogState();
}

class _ChooseLayersDialogState extends State<ChooseLayersDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  /**
   * Mátodo responsável por construir o corpo do dialog
   */
  Container _buildBody() {
    return Container(
      //LISTA DE CATEGORIAS DE CAMADAS
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Consts.groupLayers.length,
              itemBuilder: ((context, groupIndex) {
                //Grupo que está sendo percorrido
                Map<String, dynamic> currentGroup =
                    Consts.groupLayers[groupIndex];
                //Camadas do grupo que está sendo percorrido
                List<Map<String, dynamic>> camadas =
                    currentGroup["layers"] as List<Map<String, dynamic>>;
                return ExpansionTile(
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  title: CustomWidgets.buildText(
                    currentGroup["name"].toString(),
                    CustomWidgets.textColorPrimary,
                    CustomWidgets.textBigger,
                    "Montserrat",
                    textAlign: TextAlign.start,
                  ),
                  children: camadas
                      .map(
                        (camada) => Container(
                          color: Colors.white,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: CheckboxListTile(
                                title: CustomWidgets.buildText(
                                    camada["label"],
                                    CustomWidgets.textColorTerciary,
                                    CustomWidgets.textBig,
                                    "Montserrat",
                                    textAlign: TextAlign.start),
                                value: camada["checked"],
                                onChanged: (newValue) {
                                  setState(() {
                                    camada["checked"] = newValue ?? false;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              }),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: CustomWidgets.buildText(
                  "OK", Colors.white, CustomWidgets.textBig, "Montserrat"),
            ),
          )
        ],
      ),
    );
  }

  /**
   * Método responsável por construir a AppBar
   */
  AppBar _buildAppBar() {
    return AppBar(
      title: CustomWidgets.buildText(
        "Camadas Visíveis",
        Colors.white,
        CustomWidgets.textGiant,
        "Montserrat",
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Colors.indigo,
    );
  }
}
