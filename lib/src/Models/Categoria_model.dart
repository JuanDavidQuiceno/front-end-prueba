import 'dart:convert';

class Categorias {

  List<CategoriaModel> items = [];

  Categorias();

  Categorias.fromJsonList( List<dynamic> jsonList  ) {
    if ( jsonList == null ) return;
    for ( var item in jsonList  ) {
      final pelicula = new CategoriaModel.fromJson(item);
      items.add( pelicula );
    }
  }
}

CategoriaModel categoriaModelFromJson(String str) => CategoriaModel.fromJson(json.decode(str));

Map categoriaModelToJson(CategoriaModel data) => data.toJsonCrear();

class CategoriaModel {
  String id = '';
  String categoria = '';

  CategoriaModel({
    this.id,
    this.categoria,
  });

  factory CategoriaModel.fromJson(Map<String, dynamic> json) => CategoriaModel(
    id    : json["id"].toString(),
    categoria:  json["categoria"].toString(),
  );

  Map<String, dynamic> toJsonCrear() => {
    "categoria" : categoria,
  };
}