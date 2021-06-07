import 'package:flutter/material.dart';

import '../../Bloc/Provider.dart';
import '../../Models/Producto_model.dart';
import '../../Provider/Producto.dart';
import '../../Widgets/Loading.dart';
import '../../Utils/Utils.dart';
import '../../Widgets/Fondo.dart';
import 'Class/TarjetasProducto.dart';

class ProductosPage extends StatefulWidget {

  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {

  final _providerProductos = new ProductoProvider();
  // ProductoModel _producto = ProductoModel();

  List<ProductoModel> _listaProductos = new List();

  bool _isLoading = false;
  bool _cargainicial = true;

  @override
  void initState() { 
    super.initState();
    // _cargarProductos();
  }

  @override
  void dispose() { 
    
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    if(_cargainicial){
      _cargainicial = false;
      _cargarProductos();
    }
    return Scaffold(
      backgroundColor: colorsBase(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Fondo(),
          SafeArea(
            child: _body(context)
          ),
          Loading(loading: _isLoading,)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar Producto',
        child: Icon(Icons.add,size: 30.0,),
        onPressed: (){
          Navigator.pushNamed(context, 'add_product');
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    final bloc = Provider.of(context);
    if(_listaProductos.isNotEmpty){
      // bloc.cambiarListaProdcutoSink(_listaProductos);
      return StreamBuilder(
        stream: bloc.listaProductoFormStream,
        builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
          if(snapshot.hasData){
            return ListView(
              children: [
                for (ProductoModel item in snapshot.data)
                  TarjetasProducto(producto: item,)
              ],
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }else{
      if(!_isLoading){
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Parece que no hay Productos que mostrar', textAlign: TextAlign.center, style: TextStyle(color: Colors.white,)),
                )
              ),
              _campoBoton2(context, 'Volver a Intentar'),
            ],
          ),
        );
      }else{
       return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Parece que ya no hay mas productos', textAlign: TextAlign.center, style: TextStyle(color: Colors.white,)),
                )
              ),
              _campoBoton2(context, 'Volver a Intentar'),
            ],
          ),
        );
      }
    }
  }

  Widget _campoBoton2(BuildContext context, String texto) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).orientation==Orientation.landscape? 100.0: 60.0, vertical: 20.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        onPressed: (){
          // _isLoading = true;
          // _actualizar(context);
          _cargarProductos();
        },
        textColor: Colors.blue,
        color: Colors.white,
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(child: Text('Volver a Cargar'))
        ),
      ),
    );
  }

  void _cargarProductos()async{
    final bloc = Provider.of(context);
    try{
      setState(() {_isLoading = true;});
      // new Future.delayed(Duration(milliseconds: 5000), () {
        Map data = await _providerProductos.obtenerProductos();
        setState(() {_isLoading = false;});
        // Map data ={ 'ok': true, 'code': 201 , 'productos':[
        //   {'id':8,'nombre':'Portatil 3','precio':1000000,'inventario':50,'categoria':{'id':6, 'categoria':'Tecnología'}},
        //   {'id':9,'nombre':'Portatil 1','precio':1000000,'inventario':50,'categoria':{ 'id':6,'categoria':'Tecnología'}}
        // ]};
        if(data['ok']){
          print(data);
          List listado = data['productos'];      
          if(listado.isNotEmpty){
            listado.forEach((element) {
              _listaProductos.add(ProductoModel.fromJson(element));
            });
            bloc.cambiarListaProdcutoSink(_listaProductos);
          }else{
            _listaProductos.clear();
            // _listaProductos = [];
          }
        }else{
          if(data['code']==400||data['code']==401){
            alertaErrorConexion(context, '${data['titulo']}', '${data['mensaje']}');
          }else if(data['code']==406){
            Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
            alertaErrorConexion(context, '${data['titulo']}', '${data['mensaje']}');
          }else{
            alertaErrorConexion(context, 'Problemas en la verificación', 'Parece que no se completo el registro');
          }
        }
      // });
    }catch(e){
      print(e);
      setState(() {_isLoading = false;});
      alertaErrorConexion(context, 'Problemas en la verificación', 'Parece que no se completo el registro');
    }
  }
}