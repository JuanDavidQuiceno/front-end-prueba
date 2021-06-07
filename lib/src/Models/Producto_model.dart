import 'dart:convert';

import '../Models/Categoria_model.dart';

class Productos {

  List<ProductoModel> items = new List();

  Productos();

  Productos.fromJsonList( List<dynamic> jsonList  ) {
    if ( jsonList == null ) return;
    for ( var item in jsonList  ) {
      final pelicula = new ProductoModel.fromJson(item);
      items.add( pelicula );
    }
  }
}

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

Map productoModelToJsonRegister(ProductoModel data) => data.toJsonCrear();

class ProductoModel {
  String id = '';
  String nombre = '';
  String precio = '';
  String inventaria = '';
  CategoriaModel categoria;
  
  ProductoModel({
    this.id,
    this.nombre,
    this.precio,
    this.inventaria,
    this.categoria,
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
    id    : json["id"].toString(),
    nombre:  json["nombre"].toString(),
    precio    : json["precio"].toString(),
    inventaria  : json["inventario"].toString(),
    categoria  : CategoriaModel.fromJson(json["categoria"]),
  );


  Map<String, dynamic> toJsonCrear() => {
    "nombre" : nombre,
    "precio": precio,
    "inventario": inventaria,
    "categoria": categoria.id,
  };
}