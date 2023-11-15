import 'package:atlas_do_camarao/util/consts.dart';
import 'package:atlas_do_camarao/util/prefs.dart';
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Camadas Visíveis",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
          ),
          backgroundColor: Colors.indigo,
        ),
        body: Container(
          //LISTA DE CATEGORIAS DE CAMADAS
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
                title: Text(
                  currentGroup["name"].toString(),
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: camadas
                    .map(
                      (camada) => Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: CheckboxListTile(
                            title: Text(
                              camada["label"],
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            value: camada["checked"],
                            onChanged: (newValue) {
                              setState(() {
                                camada["checked"] = newValue ?? false;
                              });
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            }),
          ),
        ),
      ),
    );
  }
}
