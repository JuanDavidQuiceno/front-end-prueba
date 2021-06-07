import 'package:flutter/material.dart';
import '../Utils/Utils.dart';

class Fondo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: gradienteBase(),
    );
  }
}