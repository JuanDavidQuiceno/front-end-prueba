import 'package:flutter/cupertino.dart';

import '../../../Bloc/Provider.dart';
import '../../../Models/Categoria_model.dart';
import '../../../Provider/categoria.dart';

final _providerCategoria = new CategoriaProvider();

getCategorias(BuildContext context)async{
  final patron = Provider.of(context);
  List _categorias = [];
  try{
    Map data = await _providerCategoria.obtenercategorias();
    // Map data = {'ok':true, 'code':201, 'titulo': 'Producto Actualizado', 'mensaje':'Actualizamos el producto correctamente', 'categorias': [{'id': 7, 'categoria': 'Vehiculos'},{'id': 6, 'categoria': 'Tecnología'},{'id': 10, 'categoria': 'Hogar'}]};
    if(data['ok']){
      _categorias = data['categorias'];
      List<CategoriaModel>  _listaCategoria= [];
      _categorias.forEach((element) {
        _listaCategoria.add(CategoriaModel.fromJson(element));
      });
      patron.cambiarListaCategoriasSink(_listaCategoria);
      print(patron.listaCategoriaEmitida);
    }
  }catch(e){
    patron.cambiarListaCategoriasSink(_categorias=[]);
  }
}