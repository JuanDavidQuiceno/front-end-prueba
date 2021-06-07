import 'dart:async';

import 'package:flutter/material.dart';
import '../Preferences/preferencias_usuario.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // var _visible = true;
  final _prefs = new PreferenciasUsuario();

  // AnimationController animationController;
  Animation<double> animation;

  AnimationController controller;
  // Animation<double> animation;


  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacementNamed(context, '${_prefs.ultimaPagina}');
  }

  @override
  dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    startTime();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'assets/Helios-pyp.png',
                width: MediaQuery.of(context).size.width*0.5
              ),
              SizedBox(height: 20.0,),
              Container(
                width: MediaQuery.of(context).size.width*0.6,
                child: LinearProgressIndicator(
                  minHeight: 5.0,
                  value:  animation.value,
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}