import 'package:atlas_do_camarao/util/custom_widgets.dart';
import 'package:atlas_do_camarao/util/prefs.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/choose_layers_dialog.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/filter_dialog.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/host_config_dialog.dart';
import 'package:atlas_do_camarao/view/tela_principal/widgets/mapa/map.dart';
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  bool _firstOpen = true;

  TelaPrincipal({super.key});

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

  @override
  void initState() {
    if(Prefs.getString("HOST") == null){
      Prefs.setString("HOST", "0.0.0.0");
    }
    if(Prefs.getString("PORT") == null){
      Prefs.setString("PORT", "8080");
    }
    super.initState();
  }

  /**
   * Método responsável por construir a AppBar da tela
   */
  AppBar _buildAppBar() {
    return AppBar(
      title: CustomWidgets.buildText("Atlas do Camarão", Colors.white, CustomWidgets.textGiant, "Montserrat"),
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
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return HostConfigDialog();
                },
              ).then((value) => setState(() {}));
            },
            child: Icon(
              Icons.settings_sharp,
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
  _buildBody() {
    return FutureBuilder(
      future: Prefs.getString("HOST"),
      builder: (context, snapshotHost) {
        if (snapshotHost.hasData) {
          return FutureBuilder(
            future: Prefs.getString("PORT"),
            builder: (context, snapshotPort) {
              if(snapshotPort.hasData){
                var host = snapshotHost.data!;
                var port = snapshotPort.data!;
                return SafeArea(child: new Mapa(_index, _layer, _range, host, port));
              }else{
                return CircularProgressIndicator();
              }
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
