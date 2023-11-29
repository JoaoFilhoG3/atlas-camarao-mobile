import 'package:atlas_do_camarao/util/custom_widgets.dart';
import 'package:atlas_do_camarao/util/consts.dart';
import 'package:atlas_do_camarao/util/prefs.dart';
import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  //Valor do Slider
  double _sliderValue = 0;

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
      padding: EdgeInsets.all(16),
      //LISTA DE CATEGORIAS DE CAMADAS
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidgets.buildText(
            "Raio de exibição: ${(_sliderValue == 0) ? "nenhum" : _sliderValue.toInt().toString() + "Km"}",
            CustomWidgets.textColorPrimary,
            CustomWidgets.textBig,
            "Montserrat",
            textAlign: TextAlign.start,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (_sliderValue - 10 >= 0) {
                        _sliderValue -= 10;
                      }
                    });
                  },
                  icon: Icon(Icons.minimize)),
              Expanded(
                child: Slider(
                  value: _sliderValue,
                  min: 0,
                  max: 500,
                  divisions: 50,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                      print(_sliderValue);
                    });
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (_sliderValue + 10 <= 500) {
                        _sliderValue += 10;
                      }
                    });
                  },
                  icon: Icon(Icons.add)),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
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
        "Filtragem de Resultados",
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
