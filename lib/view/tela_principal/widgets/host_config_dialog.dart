import 'package:atlas_do_camarao/util/custom_widgets.dart';
import 'package:atlas_do_camarao/util/prefs.dart';
import 'package:flutter/material.dart';

class HostConfigDialog extends StatefulWidget {
  HostConfigDialog({super.key});

  @override
  State<HostConfigDialog> createState() => _HostConfigDialogState();
}

class _HostConfigDialogState extends State<HostConfigDialog> {
  var _txtHost = TextEditingController();
  var _txtPort = TextEditingController();

  @override
  void initState() {
    Prefs.getString("HOST").then((value) => setState(() => _txtHost.text = value));
    Prefs.getString("PORT").then((value) => setState(() => _txtPort.text = value));
    super.initState();
  }
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

  /***
   * Método responsável por criar a AppBar do Dialog
   */
  _buildAppBar() {
    return AppBar(
      title: CustomWidgets.buildText(
        "Configure o Servidor",
        Colors.white,
        CustomWidgets.textGiant,
        "Montserrat",
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Colors.indigo,
    );
  }

  /***
   * Método responsável por criar o corpo do Dialog
   */
  _buildBody() {
    Prefs.getString("IP");
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidgets.buildText(
            "Ip:",
            CustomWidgets.textColorPrimary,
            CustomWidgets.textBig,
            fontWeight: FontWeight.bold,
            "Montserrat",
          ),
          SizedBox(height: 3),
          CustomWidgets.buildTextField("Digite o ip do servidor.", controller: _txtHost),
          SizedBox(height: 5),
          CustomWidgets.buildText(
            "Porta:",
            CustomWidgets.textColorPrimary,
            CustomWidgets.textBig,
            fontWeight: FontWeight.bold,
            "Montserrat",
          ),
          SizedBox(height: 3),
          CustomWidgets.buildTextField("Digite a porta do servidor.", controller: _txtPort),
          SizedBox(height: 5),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              onPressed: () {
                Prefs.setString("HOST", _txtHost.text);
                Prefs.setString("PORT", _txtPort.text);
                Navigator.pop(context, {"host":_txtHost.text, "port":_txtPort.text});
              },
              child: CustomWidgets.buildText("Salvar", Colors.white, CustomWidgets.textBig, "Montserrat"),
            ),
          ),
        ],
      ),
    );
  }
}
