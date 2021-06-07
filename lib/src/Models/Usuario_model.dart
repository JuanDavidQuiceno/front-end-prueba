import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

Map usuarioModelToJsoLogin(UsuarioModel data) => data.toJsonLogin();
Map usuarioModelToJsonRegister(UsuarioModel data) => data.toJsonRegister();

class UsuarioModel {
  String id = '';
  String firsname = '';
  String lastname = '';
  String email = '';
  String password = '';
  
  
  UsuarioModel({
    this.id,
    this.firsname,
    this.lastname,
    this.email,
    this.password,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
    // id    : json["id"].toString(),
    firsname:  json["firsname"].toString(),
    lastname    : json["lastname"].toString(),
    email  : json["email"].toString(),
    // password  : json["password"].toString(),
  );

  Map<String, dynamic> toJsonLogin() => {
    "email": email,
    "password": password,
  };

  Map<String, dynamic> toJsonRegister() => {
    "firsname" : firsname,
    "lastname": lastname,
    "email": email,
    "password": password,
  };
}