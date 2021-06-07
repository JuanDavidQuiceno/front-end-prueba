import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../Utils/Utils.dart';

class InicioPage extends StatefulWidget {

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {

  @override
  void initState() { 
    super.initState(); 

  }

  @override
  void dispose() { 
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _alertaSalir,
      child: Scaffold(
        backgroundColor: colorsBase(),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: gradienteBase(),
            ),
            _body(context)
          ],
        )
      ),
    );
  }

  Future<bool> _alertaSalir()async{
    return showDialog(
      context: context,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        content: Text('¿Quieres salir de la aplicación?'),
        actions: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar',)
          ),
          FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            color: Colors.blue,
            onPressed: () => Navigator.pop(context, true),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Salir'),
                SizedBox(width: 5.0,),
                Icon(Icons.logout)
              ],
            )
          ),
        ],
      )
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Image.asset('assets/image/bienvenida.png',)),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text('Te damos la bienvenida', style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              SizedBox(height: 10.0,),
              Text('Si es tu primera vez en la aplicación, te aconsejamos registarse primero', style: TextStyle(color: Colors.white, fontSize: 16.0), textAlign: TextAlign.center),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _loginBoton(context),
              _registreBoton(context)
            ],
          ),
        )
      ],
    );
  }

  Widget _loginBoton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).orientation==Orientation.landscape? 100.0: 20.0, vertical: 5.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        onPressed: (){
          Navigator.pushNamed(context, 'login');
        },
        textColor: Theme.of(context).accentColor,
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.white
          ),
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Inicia Sesion', style: TextStyle(fontSize: 16)),
              SizedBox(width: 5.0,),
              Icon(Icons.login)
            ],
          ),
        ),
      ),
    );
  }

  Widget _registreBoton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).orientation==Orientation.landscape? 100.0: 20.0, vertical: 5.0),
      child: OutlineButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        onPressed: (){
          Navigator.pushNamed(context, 'register');
        },
        color: Colors.white,
        splashColor: Colors.white70,
        borderSide: BorderSide(
          color: Colors.white
        ),
        textColor: Colors.white,
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.transparent
          ),
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Registrarmea', style: TextStyle(fontSize: 16)),
              SizedBox(width: 5.0,),
              Icon(Icons.person_add_alt)
            ],
          ),
        ),
      ),
    );
  }
}