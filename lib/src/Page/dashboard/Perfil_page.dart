import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Bloc/PatronBloc.dart';
import '../../Bloc/Provider.dart';
import '../../Models/Usuario_model.dart';
import '../../Preferences/preferencias_usuario.dart';
import '../../Utils/Utils.dart';
import '../../Widgets/Fondo.dart';

class PerfilPage extends StatefulWidget {

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  final _prefs = PreferenciasUsuario();

  @override
  void initState() { 
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.green
      )
    ); 
  }

  @override
  void dispose() { 
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.blue[900]
      )
    ); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorsBase(),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Fondo(),
            SafeArea(
              child: _body(context),
              
            ),
            // Loading(loading: _isLoading,)
            // _cerrarSesion(context)
          ],
        )
    );
  }

   Widget _body(BuildContext context) {
    final bloc = Provider.of(context);
    return Column(
      children: [
        contenedorNombre(context, bloc),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15.0,),
                  Text('Tu cuenta', style: TextStyle(color: Colors.white, fontSize: 18.0), textAlign: TextAlign.start,),
                  SizedBox(height: 10.0,),
                  Divider(color: Colors.white,),
                  SizedBox(height: 10.0,),
                  Text('Ajustes', style: TextStyle(color: Colors.white, fontSize: 18.0),textAlign: TextAlign.start),
                  SizedBox(height: 10.0,),
                  Divider(color: Colors.white,),
                  SizedBox(height: 10.0,),
                  Text('Ayuda', style: TextStyle(color: Colors.white, fontSize: 18.0), textAlign: TextAlign.start),
                  SizedBox(height: 10.0,),
                ],
              ),
            ],
          ),
        ),
        _cerrarSesion(context, bloc)
      ],
    );
  }

  Widget contenedorNombre(BuildContext context, PatronBloc patronBloc) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.green,
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: patronBloc.usuarioFormStream ,
            builder: (BuildContext context, AsyncSnapshot<UsuarioModel> snapshot){
              try{
                return Theme(
                  data: ThemeData(
                    primarySwatch: Colors.green
                  ),
                  child: UserAccountsDrawerHeader(
                    accountName: Text("${snapshot.data.firsname} ${snapshot.data.lastname}"??'Verificar',),
                    accountEmail: Text("${snapshot.data.email}"??'Verificar'),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text("${snapshot.data.firsname.substring(0, 1).toUpperCase()}${snapshot.data.lastname.substring(0, 1).toUpperCase()}"??'nn',style: TextStyle(fontSize: 25.0),),
                    ),
                  ),
                );
              }catch(e){
                return Theme(
                  data: ThemeData(
                    primarySwatch: Colors.green
                  ),
                  child: UserAccountsDrawerHeader(
                    accountName: Text('Verificar',style: TextStyle(fontSize: 15.0)),
                    accountEmail: Text('Verificar',style: TextStyle(fontSize: 15.0)),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text('nn',style: TextStyle(fontSize: 40.0),),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      // child: Text('${patronBloc.usuarioStream}', style: TextStyle(fontSize: 20.0, color: Colors.white,),)
    );
  }

  Widget _cerrarSesion(BuildContext context, PatronBloc bloc){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 1.0,
                offset: Offset(0.0, 1.0),
                spreadRadius: 1.0
              )
            ]
          ),
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: Center(
            child: Theme(
              data: ThemeData(
                primarySwatch: Colors.red,
                accentColor: Colors.red,
              ),
              child: OutlineButton(
                onPressed: (){
                  FocusScope.of(context).unfocus();
                  showDialog(
                    context: context,
                    // barrierColor: Colors.red.withOpacity(0.5),
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titleTextStyle: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                        // title: Text('Cerrar Sesión', textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,),
                        content: Text("¿Seguro quieres cerrar la sesión?"),
                        actions: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            color: Colors.green,
                            child: Row(
                              children: [
                                Text("Cancelar", style: TextStyle(color: Colors.white)),
                                // Icon(Icons.cance, color: Colors.white, size: 15.0,),
                              ],
                            ),
                            onPressed: () {
                              Navigator.pop(context, false);
                            }
                          ),

                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            color: Colors.red,
                            child: Row(
                              children: [
                                Text("Cerrar Sesión", style: TextStyle(color: Colors.white)),
                                SizedBox(width: 5.0,),
                                Icon(Icons.logout, color: Colors.white, size: 15.0,),
                              ],
                            ),
                            onPressed: () {
                              _prefs.token = '';
                              UsuarioModel usuario = new UsuarioModel();
                              bloc.cambiarUsuarioSink(usuario);
                              Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
                            }
                          ),
                        ]
                      );
                    }
                  );
                },            
                splashColor: Colors.white30,
                focusColor: Colors.red,
                padding:const EdgeInsets.all(0.0),
                borderSide: BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
                      SizedBox(width: 10.0,),
                      Icon(Icons.logout, color: Colors.red,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}