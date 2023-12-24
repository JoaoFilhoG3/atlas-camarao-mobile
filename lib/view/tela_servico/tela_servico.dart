import 'dart:math';

import 'package:atlas_do_camarao/model/feature.dart';
import 'package:atlas_do_camarao/util/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class TelaServico extends StatefulWidget {
  Feature feature;

  TelaServico(this.feature, {super.key});

  @override
  State<TelaServico> createState() => _TelaServicoState(feature);
}

class _TelaServicoState extends State<TelaServico> {
  Feature feature;
  late LatLng featureCoord;

  _TelaServicoState(this.feature) {
    featureCoord = LatLng(
      feature.geometry!.coordinates![1],
      feature.geometry!.coordinates![0],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildContainer(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }



  /**
   * Método responsável por construir a AppBar da tela de serviços
   */
  AppBar _buildAppBar() {
    return AppBar(
      title: CustomWidgets.buildText(feature.properties!.nmFantasia!,
          Colors.white, CustomWidgets.textGiant, "Montserrat", textOverflow: TextOverflow.ellipsis),
      backgroundColor: Colors.indigo,
    );
  }

  /**
   * Método responsável por construir o corpo da tela de serviços
   */
  Container _buildContainer() {
    return Container(
      child: Column(children: [
        Image.network(loadingBuilder:
                (context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
            "https://maps.geoapify.com/v1/staticmap"
            "?style=osm-carto"
            "&width=600"
            "&height=400"
            "&center=lonlat:${featureCoord.longitude},${featureCoord.latitude}"
            "&zoom=16"
            "&marker=lonlat:${featureCoord.longitude},${featureCoord.latitude};type:material;color:%231f63e6;size:x-large;whitecircle:yes"
            "&apiKey=7a12c20af54d4293b1811838d7aaa4c6"),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomWidgets.buildText(
                  feature.properties!.nmFantasia! != ""
                      ? feature.properties!.nmFantasia!
                      : feature.properties!.rzSocial!,
                  CustomWidgets.textColorPrimary,
                  CustomWidgets.textGiant,
                  "Montserrat",
                  fontWeight: FontWeight.bold),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomWidgets.buildText(
                      "Endereço: ",
                      CustomWidgets.textColorPrimary,
                      CustomWidgets.textBig,
                      "Montserrat",
                      fontWeight: FontWeight.bold),
                  Flexible(
                    child: CustomWidgets.buildText(
                      textOverflow: TextOverflow.visible,
                        feature.properties!.endereco! +
                            ", " +
                            feature.properties!.munic! +
                            ", " +
                            feature.properties!.uf!,
                        CustomWidgets.textColorPrimary,
                        CustomWidgets.textBig,
                        "Montserrat", textAlign: TextAlign.start),
                  ),
                ],
              ),
              Row(
                children: [
                  CustomWidgets.buildText(
                      "Telefone: ",
                      CustomWidgets.textColorPrimary,
                      CustomWidgets.textBig,
                      "Montserrat",
                      fontWeight: FontWeight.bold),
                  CustomWidgets.buildText(
                      "(${feature.properties!.ddd}) ${feature.properties!.telefone}",
                      Colors.blue,
                      CustomWidgets.textBig,
                      "Montserrat"),
                ],
              ),
              Row(
                children: [
                  CustomWidgets.buildText(
                      "Email: ",
                      CustomWidgets.textColorPrimary,
                      CustomWidgets.textBig,
                      "Montserrat",
                      fontWeight: FontWeight.bold),
                  CustomWidgets.buildText(feature.properties!.email!,
                      Colors.blue, CustomWidgets.textBig, "Montserrat"),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  /**
   * Método responsável por construir o Floating Action Button da tela
   */
  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: (){
        Navigator.pop(context, feature);
      },
      child: Icon(Icons.route, color: Colors.white,),
    );
  }
}
