import 'package:flutter/material.dart';
import 'package:prueba_tecnica/src/Bloc/Provider.dart';
import 'package:prueba_tecnica/src/Models/Categoria_model.dart';
import 'package:prueba_tecnica/src/Models/Producto_model.dart';
import 'package:prueba_tecnica/src/Page/Inicio/Class/Icon-titulo.dart';
import 'package:prueba_tecnica/src/Page/Inicio/Class/inputFormaularios.dart';
import 'package:prueba_tecnica/src/Provider/categoria.dart';
import 'package:prueba_tecnica/src/Utils/Utils.dart';
import 'package:prueba_tecnica/src/Widgets/Fondo.dart';
import 'package:prueba_tecnica/src/Widgets/Loading.dart';

class AddCategoryPage extends StatefulWidget {

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {

  final _keyform = GlobalKey<FormState>();
  final _providerCategoria = new CategoriaProvider();
  CategoriaModel categoria = new CategoriaModel();
  
  bool _isLoading = false;

  @override
  void initState() { 
    super.initState();
    
  }

  @override
  void dispose() { 
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      )
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconTitutlo(titulo: 'Crear Producto', icon: Icons.widgets_rounded, ),
          SizedBox(height: 40.0,),
          _formulario(context),
          SizedBox(height: 40.0,),
        ],
      ),
    );
  }

  Widget _formulario(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.white,
      shape: bordeRedondeado(),
      child: Column(
        children: [
          SizedBox(height: 20.0,),
          Form(
            key: _keyform,
            child: Column(
              children: [
                SizedBox(height: 20.0,),
                _campoNombre(context),
                SizedBox(height: 20.0,),
                _botonEnviar(context),
                SizedBox(height: 30.0,),
              ],
            ),
          ),
          SizedBox(height: 20.0,),
        ],
      ),
    );
  }

  Widget _campoNombre(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        style: TextStyle(
          color: Colors.black,
        ),
        toolbarOptions: ToolbarOptions(
          copy: true,
          cut: true,
          paste: true,
          selectAll: true
        ),
        decoration: inputFormularios('Nombre Categoria'),
        validator: (value){
          if(value != ''){
            return null;
            // return 'No parece un correo valido';
          }else{
            return 'Campo requerido';
          }
        },
        onSaved: (value){
          categoria.categoria= value.toString();
        },
      ),
    );
  }

  Widget _botonEnviar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).orientation==Orientation.landscape? 100.0: 20.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        onPressed:(){
          FocusScope.of(context).unfocus();
          _submit(context);
        },
        textColor: Colors.white,
        color: Colors.blue[500],
        padding: const EdgeInsets.all(0.0),
        child: Container(
          child: Center(
            child: Text('Crear Categoria')
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) async{
    final bloc = Provider.of(context);
    try {
      if(_keyform.currentState.validate()){
        _keyform.currentState.save();
        setState(() {_isLoading = true;});
        print(categoriaModelToJson(categoria));
        // new Future.delayed(Duration(milliseconds: 1000), () {
          Map data = await _providerCategoria.crearCategoria(categoria);
          // Map data = {'ok':true, 
          //   'code':201, 
          //   'titulo': 'Producto Actualizado', 
          //   'mensaje':'Actualizamos el producto correctamente',
          //   'categorias': [
          //     {'id': 7, 'categoria': 'Vehiculos'},
          //     {'id': 6,'categoria': 'Tecnología'},
          //   ]
          // };
          setState(() {_isLoading = false;});
          if(data['ok']){
            List listado = data['categorias'];
            List<CategoriaModel> _listaProducto = [];
            if(listado.isNotEmpty){
              listado.forEach((element) {
                _listaProducto.add(CategoriaModel.fromJson(element));
              });
              bloc.cambiarListaCategoriasSink(_listaProducto);
            }
            Navigator.pop(context, true);
            alertaErrorConexion(context, '${data['titulo']}', '${data['mensaje']}');
          }else{
            if(data['code']==400||data['code']==401){
              alertaErrorConexion(context, '${data['titulo']}', '${data['mensaje']}');
            }else if(data['code']==406){
              Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
              alertaErrorConexion(context, '${data['titulo']}', '${data['mensaje']}');
            }else{
              alertaErrorConexion(context, '${data['titulo']}', '${data['mensaje']}');
            }
          }
        // });
      }
    }catch(general){
      print(general);
      setState(() {_isLoading = false;});
      alertaErrorConexion(context, 'Upss','No se pudo establecer conexion con el servidor, intente nuevamente');
    }
  }
}