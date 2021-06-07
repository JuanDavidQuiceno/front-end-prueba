import 'package:flutter/material.dart';


class IconTitutlo extends StatelessWidget {
  final String titulo;
  final IconData icon;
  IconTitutlo({Key key,  @required this.titulo, @required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.0,),
        Icon(icon, size: 100.0, color: Colors.white,),
        SizedBox(height: 20.0,),
        Text(titulo??'Sin Información', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),)
      ],
    );
  }
}