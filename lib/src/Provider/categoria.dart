import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_tecnica/src/Models/Categoria_model.dart';
import 'package:prueba_tecnica/src/Preferences/preferencias_usuario.dart';

import '../Utils/Utils.dart';

class CategoriaProvider{

  final _url = urlBase();
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> obtenercategorias()async{

    final userHeader = {
      'Authorization': 'Bearer ${_prefs.token}'
    };
    final respuesta = await http.get('$_url/categorias', headers: userHeader);
    final decodeRespuesta = json.decode(respuesta.body );
    if(respuesta.statusCode == 201 && decodeRespuesta.containsKey('categorias')){
      return {'ok': true, 'code': respuesta.statusCode , 'categorias': decodeRespuesta['categorias'] };
    }else if(respuesta.statusCode == 401 || respuesta.statusCode == 400){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': decodeRespuesta['error']};
    }if(respuesta.statusCode == 406){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': decodeRespuesta['error'], 'mensaje': 'Cerramos la sesión por seguridad'};
    }else{
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': 'tenemos problemas para cargar los datos, intente nuevamente'};
    }
}

  Future<Map<String, dynamic>> crearCategoria(CategoriaModel categoria)async{

    final userHeader = {
      'Authorization': 'Bearer ${_prefs.token}'
    };
    
    final respuesta = await http.post('$_url/categorias', headers: userHeader, body: categoriaModelToJson(categoria));
    final decodeRespuesta = json.decode(respuesta.body);
    if(respuesta.statusCode == 201 && decodeRespuesta.containsKey('categorias') && decodeRespuesta.containsKey('msg')){
      return {'ok': true, 'code': respuesta.statusCode, 'titulo': decodeRespuesta['msg'], 'mensaje':'Categoria creada correctamente', 'categorias':decodeRespuesta['categorias']};
    }else if(respuesta.statusCode == 401 || respuesta.statusCode == 400){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': decodeRespuesta['error']};
    }if(respuesta.statusCode == 406){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': decodeRespuesta['error'], 'mensaje': 'Cerramos la sesión por seguridad'};
    }else{
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': 'tenemos problemas para cargar los datos, intente nuevamente'};
    }
  }

  Future<Map<String, dynamic>> actualizarCategoria(CategoriaModel categoria)async{

    final userHeader = {
      'Authorization': 'Bearer ${_prefs.token}'
    };
    
    final respuesta = await http.put('$_url/categorias/${categoria.id}', headers: userHeader, body:categoriaModelToJson(categoria));
    final decodeRespuesta = json.decode(respuesta.body);
    if(respuesta.statusCode == 201 && decodeRespuesta.containsKey('categorias') && decodeRespuesta.containsKey('msg')){
      return {'ok': true, 'code': respuesta.statusCode, 'titulo': decodeRespuesta['msg'], 'mensaje': 'Actualizamos el producto correctamente', 'categorias':decodeRespuesta['categorias']};
    }else if(respuesta.statusCode == 401 || respuesta.statusCode == 400){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': decodeRespuesta['error']};
    }if(respuesta.statusCode == 406){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': decodeRespuesta['error'], 'mensaje': 'Cerramos la sesión por seguridad'};
    }else{
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': 'tenemos problemas para cargar los datos, intente nuevamente'};
    }
  }

  Future<Map<String, dynamic>> eliminarCategoria(String id)async{
    final userHeader = {
      'Authorization': 'Bearer ${_prefs.token}'
    };
    final respuesta = await http.delete('$_url/categorias/$id', headers: userHeader);
    final decodeRespuesta = json.decode(respuesta.body);
    if(respuesta.statusCode == 201 && decodeRespuesta.containsKey('categoria') && decodeRespuesta.containsKey('msg')){
      return {'ok': true, 'code': respuesta.statusCode,  'titulo': decodeRespuesta['msg'], 'mensaje': 'Se elimino de manera correcta la categoria'};
    }else if(respuesta.statusCode == 401 || respuesta.statusCode == 400){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': decodeRespuesta['error']};
    }else if(respuesta.statusCode == 406){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': decodeRespuesta['error'], 'mensaje': 'Cerramos la sesión por seguridad'};
    }else{
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': 'tenemos problemas para cargar los datos, intente nuevamente'};
    }
  }
}