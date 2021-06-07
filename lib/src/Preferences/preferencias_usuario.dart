import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:
  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...
*/

class PreferenciasUsuario{
  
  //patron singleton maneja preferencias unicas
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();
  factory PreferenciasUsuario(){
    return _instancia;
  }
  SharedPreferences _prefs;
  //final patron single
  PreferenciasUsuario._internal();

  initPrefs()async{
    this._prefs = await SharedPreferences.getInstance();
  }

  get tokenfcm{return _prefs.getString('tokenfcm') ?? 'not found';}
  set tokenfcm(String value){_prefs.setString('tokenfcm', value);}


//====================Variables de usuario
  get token{return _prefs.getString('token') ?? '';}
  set token(String value){_prefs.setString('token', value);}

//========================variables de control de app
  get ultimaPagina{return _prefs.getString('ultimaPagina') ?? 'inicio';}
  set ultimaPagina(String value){_prefs.setString('ultimaPagina', value);}

  get guardarcorreo{return _prefs.getBool('guardarcorreo') ?? false;}
  set guardarcorreo(bool value){_prefs.setBool('guardarcorreo', value);}

  get correo{return _prefs.getString('correo') ?? 'inicio';}
  set correo(String value){_prefs.setString('correo', value);}

}