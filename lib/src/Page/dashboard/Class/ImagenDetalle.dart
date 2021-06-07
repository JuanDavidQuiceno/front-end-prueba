import 'package:flutter/material.dart';


class ImagenDetallePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.3,
      width: MediaQuery.of(context).size.width,
      child: Image.asset('assets/image/not-found.png', fit: BoxFit.cover,),
    );
  }
}