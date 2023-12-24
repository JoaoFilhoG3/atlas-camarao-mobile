import 'package:atlas_do_camarao/util/custom_widgets.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/choose_layers_dialog.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/filter_dialog.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/map.dart';
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  //Filtragem por raio
  int _index = 0;
  String _layer = "";
  double _range = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  /**
   * Método responsável por construir a AppBar da tela
   */
  AppBar _buildAppBar() {
    return AppBar(
      title: CustomWidgets.buildText(
          "Atlas do Camarão", Colors.white, CustomWidgets.textGiant, "Montserrat"),
      backgroundColor: Colors.indigo,
      actions: [_buildAppBarActions()],
    );
  }

  /**
   * Método responsável por construir os actions da AppBar
   */
  Widget _buildAppBarActions() {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return FilterDialog(_index, _range);
                }).then((value) => setState(() {
                  _index = value["index"];
                  _layer = value["layer"];
                  _range = value["range"];
                }));
          },
          child: Icon(
            Icons.filter_list,
            color: Colors.white,
            size: 26.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: GestureDetector(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ChooseLayersDialog();
                  }).then((value) => setState(() {}));
            },
            child: Icon(
              Icons.layers,
              color: Colors.white,
              size: 26.0,
            ),
          ),
        ),
      ],
    );
  }

  /**
   * Método responsável por construir o corpo da tela
   */
  SafeArea _buildBody() {
    return SafeArea(child: new Mapa(_index, _layer, _range));
  }
}
