import 'package:flutter/material.dart';

String urlBase(){
  return 'http://localhost';
}

Color colorsBase(){
  return Colors.blue[900];
}

List<Color> colorsGradiente(){
  return [Colors.blue[900], Colors.blue[800], Colors.blue[700]];
}

BoxDecoration gradienteBase(){
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: colorsGradiente()
    )
  );
}

ShapeBorder bordeRedondeado(){
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0));
}

void alertaErrorConexion(BuildContext context, String titulo, String error) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        titleTextStyle: TextStyle(color: Theme.of(context).accentColor, fontSize: 20.0, fontWeight: FontWeight.bold),
        title: new Text("$titulo"),
        content: new Text("$error"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          // ignore: deprecated_member_use
          FlatButton(
            child: new Text("Aceptar"),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      );
    },
  );
}