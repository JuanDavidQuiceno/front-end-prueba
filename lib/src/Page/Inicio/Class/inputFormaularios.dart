
import 'package:flutter/material.dart';

InputDecoration inputFormulariosStream(String titulo, String error){
  return InputDecoration(
    // fillColor: Color(0xFFF2F2F2),
    // fillColor: Colors.blue.shade50,
    labelText: titulo,
    labelStyle: TextStyle(color: Colors.black),
    hoverColor: Colors.orange,
    filled: true,
    isDense: true,
    // hintText: "Email",
    // hintStyle: TextStyle(fontSize: 16,color: Color(0xFFB3B1B1)),
    errorText: error,
    focusedBorder: decoracion(Colors.black, 1.0, 25.0),
    disabledBorder: decoracion(Colors.black, 1.0, 25.0),
    enabledBorder: decoracion(Colors.black, 1.0, 25.0),
    border: decoracion(Colors.transparent, 1.0, 25.0),
    errorBorder: decoracion(Colors.red, 1.0, 25.0),
    focusedErrorBorder: decoracion(Colors.red, 1.0, 25.0),
  );
}

InputDecoration inputFormularios(String titulo){
  return InputDecoration(

    labelText: titulo,
    labelStyle: TextStyle(color: Colors.black),
    hoverColor: Colors.orange,
    filled: true,
    isDense: true,
    // hintText: "Email",
    // hintStyle: TextStyle(fontSize: 16,color: Color(0xFFB3B1B1)),
    focusedBorder: decoracion(Colors.black, 1.0, 25.0),
    disabledBorder: decoracion(Colors.black, 1.0, 25.0),
    enabledBorder: decoracion(Colors.black, 1.0, 25.0),
    border: decoracion(Colors.transparent, 1.0, 25.0),
    errorBorder: decoracion(Colors.red, 1.0, 25.0),
    focusedErrorBorder: decoracion(Colors.red, 1.0, 25.0),
  );
}

OutlineInputBorder decoracion(Color color, double ancho, double bordeRadius){
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(bordeRadius)),
    borderSide: BorderSide(width: ancho, color: color),
  );
}