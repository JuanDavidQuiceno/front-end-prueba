import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../Models/Categoria_model.dart';
import '../Models/Producto_model.dart';
import '../Models/Usuario_model.dart';

import '../Bloc/validator.dart';

class PatronBloc with Validator{
  final _datosUsuario = BehaviorSubject<UsuarioModel>();
  final _listaProductos = BehaviorSubject<List<ProductoModel>>();
  final _listaCategorias = BehaviorSubject<List<CategoriaModel>>();
  final _correoFormulario = BehaviorSubject<String>();
  final _passFormulario = BehaviorSubject<String>();

  //======= Datos usuario
  Stream<UsuarioModel> get usuarioFormStream => _datosUsuario.stream;
  Function(UsuarioModel)  get cambiarUsuarioSink => _datosUsuario.sink.add;

  //======= lista de los productos
  Stream<List<ProductoModel>> get listaProductoFormStream => _listaProductos.stream;
  Function(List<ProductoModel>)  get cambiarListaProdcutoSink => _listaProductos.sink.add;

  List<ProductoModel> get listaProductoEmitida => _listaProductos.value;

  //======= lista de los categorias
  Stream<List<CategoriaModel>> get listaCategoriasFormStream => _listaCategorias.stream;
  Function(List<CategoriaModel>)  get cambiarListaCategoriasSink => _listaCategorias.sink.add;

  List<CategoriaModel> get listaCategoriaEmitida => _listaCategorias.value; 

  //========formulario login y registrarse
  Stream<String> get correoFormStream => _correoFormulario.stream.transform(validarCorreo);
  Function(String)  get cambiarCorreoFormSink => _correoFormulario.sink.add;

  Stream<String> get passFormStream => _passFormulario.stream.transform(validarPass);
  Function(String)  get cambiarpassFormSink => _passFormulario.sink.add;
  //ultimo valor emitido
  String get correoEmitido => _correoFormulario.value;  
  String get passEmitido => _passFormulario.value;  

  Stream<bool> get formValidateStream 
    => Rx.combineLatest2(correoFormStream, correoFormStream, (doc, cor) => true);

  Stream<bool> get formLoginStrem
    => Rx.combineLatest2(correoFormStream, passFormStream, (doc, cor) => true);
  //======================================================================

  dispose(){
    _datosUsuario?.close();
    _listaProductos?.close();
    _listaCategorias?.close();
    _correoFormulario?.close();
    _passFormulario?.close();
  }
}