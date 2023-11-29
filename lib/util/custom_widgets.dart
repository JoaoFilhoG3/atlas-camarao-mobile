import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomWidgets {
  /// * Variáveis para as cores ***/
  static Color textColorPrimary = Colors.grey.shade700;
  static Color textColorSecondary = Colors.grey.shade600;
  static Color textColorTerciary = Colors.grey.shade500;

  /// * Variáveis para os tamanhos ***/
  static double textGiant = 20;
  static double textBigger = 18;
  static double textBig = 16;
  static double textMedium = 14;
  static double textSmall = 12;

  /// * Método responsável por construir um Text ***/
  static Widget buildText(
      String text, Color color, double size, String fontFamily,
      {TextAlign textAlign = TextAlign.center,
      FontWeight fontWeight = FontWeight.normal,
      TextOverflow textOverflow = TextOverflow.visible}) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      overflow: textOverflow,
    );
  }

  /// * Método responsável por construir um TextField ***/
  static Widget buildTextField(
    String hint, {
    TextEditingController? controller,
    Function(String)? onChanged,
    TextInputType? textInput,
    TextInputFormatter? inputFormatter,
    TextInputAction? inputAction,
    bool? password = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: textColorTerciary, fontSize: textBig),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4))),
      style: TextStyle(color: textColorPrimary, fontSize: textBig),
      controller: controller,
      onChanged: onChanged,
      keyboardType: textInput,
      inputFormatters: inputFormatter != null ? [inputFormatter] : [],
      textInputAction: inputAction,
      obscureText: password!,
      validator: validator,
    );
  }
}
