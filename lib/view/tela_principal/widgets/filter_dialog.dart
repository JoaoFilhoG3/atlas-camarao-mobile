import 'package:atlas_do_camarao/util/custom_widgets.dart';
import 'package:atlas_do_camarao/util/consts.dart';
import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  int _index;
  double _range;

  FilterDialog(this._index, this._range, {super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  //Valor do Slider
  double _sliderValue = 0;

  //Lista de cadeias de insumos
  List<Map<String, dynamic>> lLayers =
      Consts.groupLayers![4]["layers"]! as List<Map<String, dynamic>>;

  //Lista de labels das cadeias de insumos
  List<String> lLayerTitles = (Consts.groupLayers![4]["layers"]! as List<Map<String, dynamic>>)
      .map((e) => e["label"] as String)
      .toList();

  //Indice do Dropdown
  int _dropdownIndex = 1;

  //Valor do Dropdown
  late String _dropdownValue =
      (Consts.groupLayers![4]["layers"]! as List<Map<String, dynamic>>)[0]["label"] as String;

  @override
  Widget build(BuildContext context) {
    if (widget._index > 0) {
      _dropdownIndex = widget._index;
      _dropdownValue = (Consts.groupLayers![4]["layers"]!
          as List<Map<String, dynamic>>)[widget._index - 1]["label"] as String;
      _sliderValue = widget._range;
      widget._index = 0;
    }

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
            "Recurso:",
            CustomWidgets.textColorPrimary,
            CustomWidgets.textBig,
            "Montserrat",
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 3),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            padding: EdgeInsets.only(left: 10, right: 3),
            child: DropdownButton<String>(
              underline: Container(),
              value: _dropdownValue,
              isExpanded: true,
              items: lLayerTitles.map((e) {
                return DropdownMenuItem(
                    value: e,
                    child: CustomWidgets.buildText(
                      e,
                      CustomWidgets.textColorPrimary,
                      CustomWidgets.textBig,
                      "Montserrat",
                      textOverflow: TextOverflow.ellipsis,
                    ));
              }).toList(),
              onChanged: (value) {
                if (value is String) {
                  setState(() {
                    _dropdownIndex = lLayerTitles.indexOf(value) + 1;
                    _dropdownValue = value;
                    print(value);
                  });
                }
              },
            ),
          ),
          SizedBox(height: 10),
          CustomWidgets.buildText(
              "Raio de exibição: ${(_sliderValue == 0) ? "nenhum" : _sliderValue.toInt().toString() + "Km"}",
              CustomWidgets.textColorPrimary,
              CustomWidgets.textBig,
              "Montserrat",
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold),
          SizedBox(height: 3),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (_sliderValue - 5 >= 0) {
                        _sliderValue -= 5;
                      }
                    });
                  },
                  icon: Icon(Icons.minimize)),
              Expanded(
                child: Slider(
                  value: _sliderValue,
                  min: 0,
                  max: 500,
                  divisions: 100,
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
                      if (_sliderValue + 5 <= 500) {
                        _sliderValue += 5;
                      }
                    });
                  },
                  icon: Icon(Icons.add)),
            ],
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              onPressed: () {
                Navigator.pop(
                  context,
                  {
                    "index": _dropdownIndex,
                    "layer": _dropdownValue,
                    "range": _sliderValue,
                  },
                );
              },
              child:
                  CustomWidgets.buildText("OK", Colors.white, CustomWidgets.textBig, "Montserrat"),
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
