import 'package:flutter/material.dart';
import 'package:prueba_tecnica/src/Bloc/PatronBloc.dart';
import 'package:prueba_tecnica/src/Bloc/Provider.dart';
import 'package:prueba_tecnica/src/Models/Categoria_model.dart';
import 'package:prueba_tecnica/src/Page/Inicio/Class/inputFormaularios.dart';
import 'package:prueba_tecnica/src/Page/dashboard/Class/ImagenDetalle.dart';
import 'package:prueba_tecnica/src/Provider/categoria.dart';
import 'package:prueba_tecnica/src/Utils/Utils.dart';
import 'package:prueba_tecnica/src/Widgets/Fondo.dart';
import 'package:prueba_tecnica/src/Widgets/Loading.dart';


class DetalleCategoryPage extends StatefulWidget {

  @override
  _DetalleCategoryPageState createState() => _DetalleCategoryPageState();
}

class _DetalleCategoryPageState extends State<DetalleCategoryPage> {

  final _keyform = GlobalKey<FormState>();
  final _categoriaProvider = CategoriaProvider();
  CategoriaModel _categoria = new CategoriaModel();

  TextEditingController _inputCategoriaController = new TextEditingController();

  bool _isLoading = false;
  bool _cargarDatos = true;

  @override
  void initState() { 
    super.initState();
    
  }

  @override
  void dispose() { 
    _inputCategoriaController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _categoria =  ModalRoute.of(context).settings.arguments;
    iniciarDatos();
    return Scaffold(
      backgroundColor: colorsBase(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Fondo(),
          SafeArea(
            child: _body(context)
          ),
          Loading(loading: _isLoading,)
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ImagenDetallePage(),
          SizedBox(height: 20.0,),
          _formulario(context)
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _botonEnviar(context, 'Eliminar'),
                    _botonEnviar(context, 'Actualizar'),
                  ],
                ),
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
        controller: _inputCategoriaController,
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
            return 'Campo debe contener un nombre';
          }
        },
        onSaved: (value){
          _categoria.categoria = value.toString();
        },
      ),
    );
  }

  Widget _botonEnviar(BuildContext context, String opcion) {
    final bloc = Provider.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:  10.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        onPressed: (){
          FocusScope.of(context).unfocus();
          opcion=='Eliminar'
          ?_submitEliminar(context, bloc)
          :_submitUpdate(context, bloc);
          // _submit(context);
        },
        textColor: Colors.white,
        color: opcion == 'Eliminar'?Colors.red:Colors.blue[500],
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: Text(opcion)
        ),
      ),
    );
  }

  void _submitEliminar(BuildContext context, PatronBloc bloc) async{
    try {
      setState(() {_isLoading = true;});
      // new Future.delayed(Duration(milliseconds: 1000), () {
        Map data = await _categoriaProvider.eliminarCategoria(_categoria.id);
        // Map data = {'ok':true, 'code':201, 'titulo': 'Producto Eliminado', 'mensaje':'Se elimino de manera correcta el producto'};
        setState(() {_isLoading = false;});
        if(data['ok']){
          List<CategoriaModel> eliminado = bloc.listaCategoriaEmitida;
          eliminado.removeWhere((item) => item.id == _categoria.id);
          bloc.cambiarListaCategoriasSink(eliminado);
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
    }catch(general){
      setState(() {_isLoading = false;});
      alertaErrorConexion(context, 'Upss','No se pudo establecer conexion con el servidor, intente nuevamente');
    }
  }

  void _submitUpdate(BuildContext context, PatronBloc bloc) async{
    try {
       if(_keyform.currentState.validate()){
        _keyform.currentState.save();
        print(categoriaModelToJson(_categoria));
        setState(() {_isLoading = true;});
        // new Future.delayed(Duration(milliseconds: 1000), () {
          Map data = await _categoriaProvider.actualizarCategoria(_categoria);
          // Map data = {'ok':true, 
          //   'code':406, 
          //   'titulo': 'Producto Actualizado', 
          //   'mensaje':'Actualizamos el producto correctamente',
          //   'categorias': [
          //     {'id': 7,'categoria': 'Vehiculos'},
          //     {'id': 6,'categoria': 'Tecnología'},
          //     {'id': 12,'categoria': 'Vehiculos'},
          //     {'id': 13,'categoria': 'Vehiculos'}
          //   ]
          // };
          setState(() {_isLoading = false;});
          if(data['ok']){
            List categoriaa = data['categorias'];
            List<CategoriaModel> lista = [];
            categoriaa.forEach((item)=>lista.add(CategoriaModel.fromJson(item)));
            bloc.cambiarListaCategoriasSink(lista);
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

  void iniciarDatos() {
    if(_cargarDatos){
      _cargarDatos=false;
      _inputCategoriaController.text = _categoria.categoria;
    }
  }
}
