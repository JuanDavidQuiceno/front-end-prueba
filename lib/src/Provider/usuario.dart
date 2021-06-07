import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_tecnica/src/Preferences/preferencias_usuario.dart';

import '../Models/Usuario_model.dart';
import '../Utils/Utils.dart';

class UsuarioProvider{

  final _url = urlBase();
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> registrar(UsuarioModel user)async{
    
    final respuesta = await http.post('$_url/registre', body: usuarioModelToJsonRegister(user));
    final decodeRespuesta = json.decode(respuesta.body);
    if(respuesta.statusCode == 201 && decodeRespuesta.containsKey('msg')){
      return {'ok': true, 'code': respuesta.statusCode , 'titulo': 'Bien hecho', 'mensaje': decodeRespuesta['msg']};
    }else if(respuesta.statusCode == 401 || respuesta.statusCode == 400){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': decodeRespuesta['error']};
    }else{
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': 'tenemos problemas para cargar los datos, intente nuevamente'};
    }
  }

  Future<Map<String, dynamic>> login(UsuarioModel user)async{
    
    final respuesta = await http.post('$_url/login', body: usuarioModelToJsoLogin(user));
    final decodeRespuesta = json.decode(respuesta.body);
    if(respuesta.statusCode == 201 && decodeRespuesta.containsKey('token') && decodeRespuesta.containsKey('user')){
      _prefs.token = decodeRespuesta['token'];
      return {'ok': true, 'code': respuesta.statusCode, 'user': decodeRespuesta['error']};
    }else if(respuesta.statusCode == 401 || respuesta.statusCode == 400){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': decodeRespuesta['error']};
    }else{
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': 'tenemos problemas para cargar los datos, intente nuevamente'};
    }
  }
}