import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_tecnica/src/Models/Producto_model.dart';
import 'package:prueba_tecnica/src/Preferences/preferencias_usuario.dart';

import '../Utils/Utils.dart';

class ProductoProvider{

  final _url = urlBase();
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> obtenerProductos()async{

    final userHeader = {
      'Authorization': 'Bearer ${_prefs.token}'
    };
    final respuesta = await http.get('$_url/categorias', headers: userHeader);
    final decodeRespuesta = json.decode(respuesta.body );
    if(respuesta.statusCode == 201 && decodeRespuesta.containsKey('data')){
      return {'ok': true, 'code': respuesta.statusCode , 'data': decodeRespuesta['data'] };
    }else if(respuesta.statusCode == 401 || respuesta.statusCode == 400){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': decodeRespuesta['error']};
    }if(respuesta.statusCode == 406){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': decodeRespuesta['error'], 'mensaje': 'Cerramos la sesión por seguridad'};
    }else{
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': 'tenemos problemas para cargar los datos, intente nuevamente'};
    }
}

  Future<Map<String, dynamic>> crearProducto(ProductoModel producto)async{

    final userHeader = {
      'Authorization': 'Bearer ${_prefs.token}'
    };
    
    final respuesta = await http.post('$_url/productos', headers: userHeader, );
    final decodeRespuesta = json.decode(respuesta.body);
    if(respuesta.statusCode == 201 && decodeRespuesta.containsKey('producto') && decodeRespuesta.containsKey('msg')){
      return {'ok': true, 'code': respuesta.statusCode, 'titulo': decodeRespuesta['msg'], 'mensaje':'Producto creado correctamente', 'productos':decodeRespuesta['productos']};
    }else if(respuesta.statusCode == 401 || respuesta.statusCode == 400){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': decodeRespuesta['error']};
    }if(respuesta.statusCode == 406){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': decodeRespuesta['error'], 'mensaje': 'Cerramos la sesión por seguridad'};
    }else{
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': 'tenemos problemas para cargar los datos, intente nuevamente'};
    }
  }

  Future<Map<String, dynamic>> actualizarProducto(ProductoModel producto)async{

    final userHeader = {
      'Authorization': 'Bearer ${_prefs.token}'
    };
    
    final respuesta = await http.put('$_url/productos/${producto.id}', headers: userHeader, body: productoModelToJsonRegister(producto));
    final decodeRespuesta = json.decode(respuesta.body);
    if(respuesta.statusCode == 201 && decodeRespuesta.containsKey('producto') && decodeRespuesta.containsKey('msg')){
      return {'ok': true, 'code': respuesta.statusCode, 'titulo': decodeRespuesta['msg'], 'mensaje': 'Actualizamos el producto correctamente', 'producto':decodeRespuesta['producto']};
    }else if(respuesta.statusCode == 401 || respuesta.statusCode == 400){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': decodeRespuesta['error']};
    }if(respuesta.statusCode == 406){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': decodeRespuesta['error'], 'mensaje': 'Cerramos la sesión por seguridad'};
    }else{
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': 'tenemos problemas para cargar los datos, intente nuevamente'};
    }
  }

  Future<Map<String, dynamic>> eliminarProducto(String id)async{
    final userHeader = {
      'Authorization': 'Bearer ${_prefs.token}'
    };
    final respuesta = await http.delete('$_url/productos/$id', headers: userHeader);
    final decodeRespuesta = json.decode(respuesta.body);
    if(respuesta.statusCode == 201 && decodeRespuesta.containsKey('producto') && decodeRespuesta.containsKey('msg')){
      return {'ok': true, 'code': respuesta.statusCode,  'titulo': decodeRespuesta['msg'], 'mensaje': 'Se elimino de manera correcta el producto'};
    }else if(respuesta.statusCode == 401 || respuesta.statusCode == 400){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': decodeRespuesta['error']};
    }else if(respuesta.statusCode == 406){
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': decodeRespuesta['error'], 'mensaje': 'Cerramos la sesión por seguridad'};
    }else{
      return {'ok': false, 'code': respuesta.statusCode, 'titulo': 'Error', 'mensaje': 'tenemos problemas para cargar los datos, intente nuevamente'};
    }
  }
}