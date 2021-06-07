import 'PatronBloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget{
//   final pedido = PedidoBloc();

//   Provider({Key key, Widget child})
//     :super(key: key, child:child);

//   @override
//   bool updateShouldNotify(InheritedWidget oldWidget) => true;

//   static PedidoBloc of ( BuildContext context ){
//     return context.dependOnInheritedWidgetOfExactType<Provider>().pedido;
//   }
// }

  static Provider _instancia;

  factory Provider({Key key, Widget child}){
    if(_instancia == null){
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }
  
  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);

  final patronBloc = PatronBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
  static PatronBloc of ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>().patronBloc;
  } 
}