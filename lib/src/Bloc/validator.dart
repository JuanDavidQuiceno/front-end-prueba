import 'dart:async';

class Validator{


  final validarCorreo = StreamTransformer<String, String>.fromHandlers(
    handleData: (correo, sink){
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      if(regExp.hasMatch(correo)){
        sink.add(correo);
      }else{
        sink.addError('example@example.com');
      }
    }
  );
  final validarPass = StreamTransformer<String, String>.fromHandlers(
    handleData: (pass, sink){
      if(pass.length >= 6){
        sink.add(pass);
      }else{
        sink.addError("Minimo 6 caracteres");
      }
    }
  );
}