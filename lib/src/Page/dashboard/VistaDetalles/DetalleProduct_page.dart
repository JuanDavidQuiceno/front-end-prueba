import 'package:flutter/material.dart';
import '../../../Bloc/PatronBloc.dart';
import '../../../Bloc/Provider.dart';
import '../../../Models/Categoria_model.dart';
import '../../../Models/Producto_model.dart';
import '../../../Page/Inicio/Class/inputFormaularios.dart';
import '../../../Page/dashboard/Class/ImagenDetalle.dart';
import '../../../Page/dashboard/Class/getCategorias.dart';
import '../../../Provider/Producto.dart';
import '../../../Utils/Utils.dart';
import '../../../Widgets/Fondo.dart';
import '../../../Widgets/Loading.dart';


class DetalleProductPage extends StatefulWidget {

  @override
  _DetalleProductPageState createState() => _DetalleProductPageState();
}

class _DetalleProductPageState extends State<DetalleProductPage> {
  
  final _keyform = GlobalKey<FormState>();
  final _provideProducto = new ProductoProvider();
  ProductoModel productoModificado = new ProductoModel();

  TextEditingController _inputnNombreController = new TextEditingController();
  TextEditingController _inputPrecioController = new TextEditingController();
  TextEditingController _inputInventarioController = new TextEditingController();
  TextEditingController _inputCategoriaController = new TextEditingController();

  FocusNode _focusNombre = FocusNode();
  FocusNode _focusprecio = FocusNode();
  FocusNode _focusinventario = FocusNode();
  FocusNode _focuscategoria = FocusNode();

  bool _isLoading = false;
  bool iniciarDatos = true;

  @override
  void initState() { 
    super.initState();
    productoModificado = ProductoModel.fromJson({
      'id': '',
      'nombre': '',
      'precio': '',
      'inventario': '',
      'categoria': {
        'id': '',
        'categoria': ''
      }
    });
  }

  @override
  void dispose() { 
    _inputnNombreController?.dispose();
    _inputPrecioController?.dispose();
    _inputInventarioController?.dispose();
    _inputCategoriaController?.dispose();
    _focusNombre?.dispose();
    _focusprecio?.dispose();
    _focusinventario?.dispose();
    _focuscategoria?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    productoModificado =  ModalRoute.of(context).settings.arguments;
    _iniciarDatos(productoModificado);
    return Scaffold(
      backgroundColor: colorsBase(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Fondo(),
          SafeArea(
            child: _body(context, productoModificado)
          ),
          Loading(loading: _isLoading,)
        ],
      ),
    );
  }

  Widget _body(BuildContext context, ProductoModel producto) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ImagenDetallePage(),
          SizedBox(height: 20.0,),
          _formulario(context, producto)
        ],
      ),
    );
  }

  Widget _formulario(BuildContext context, ProductoModel producto) {
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
                 SizedBox(height: 10.0,),
                _campoPrecio(context),
                SizedBox(height: 10.0,),
                _campoInventario(context),
                SizedBox(height: 10.0,),
                _campoCategoria(context, producto),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _botonEnviar(context, 'Eliminar', producto),
                    _botonEnviar(context, 'Actualizar', producto),
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

  Widget _botonEnviar(BuildContext context, String opcion, ProductoModel producto) {
    final bloc = Provider.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:  10.0),
      // ignore: deprecated_member_use
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        onPressed: (){
          FocusScope.of(context).unfocus();
          opcion=='Eliminar'
          ?_submitEliminar(context, producto, bloc)
          :_submitUpdate(context, producto, bloc);
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

  Widget _campoNombre(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        focusNode: _focusNombre,
        controller: _inputnNombreController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_focusprecio);
          // _submit(context);
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
        decoration: inputFormularios('Nombre Producto'),
        validator: (value){
          if(value != ''){
            return null;
            // return 'No parece un correo valido';
          }else{
            return 'Campo debe contener un nombre';
          }
        },
        onSaved: (value){
          productoModificado.nombre = value.toString();
        },
      ),
    );
  }

  Widget _campoPrecio(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        focusNode: _focusprecio,
        controller: _inputPrecioController,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_focusinventario);
          // _submit(context);
        },
        style: TextStyle(
          color: Colors.black,
        ),
        toolbarOptions: ToolbarOptions(
          copy: false,
          cut: false,
          paste: false,
          selectAll: false
        ),
        decoration: inputFormularios('Precio Producto'),
        validator: (value){
          if(value != ''){
            return null;
            // return 'No parece un correo valido';
          }else{
            return 'Campo requerido';
          }
        },
        onSaved: (value){
          productoModificado.precio = value.toString();
        },
      ),
    );
  }

  Widget _campoInventario(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        focusNode: _focusinventario,
        controller: _inputInventarioController,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_focuscategoria);
          // _submit(context);
        },
        style: TextStyle(
          color: Colors.black,
        ),
        toolbarOptions: ToolbarOptions(
          copy: false,
          cut: false,
          paste: false,
          selectAll: false
        ),
        decoration: inputFormularios('Apellido'),
        validator: (value){
          if(value != ''){
            return null;
            // return 'No parece un correo valido';
          }else{
            return 'Campo debe contener un nombre';
          }
        },
        onSaved: (value){
          productoModificado.inventaria = value.toString();
        },
      ),
    );
  }

  Widget _campoCategoria(BuildContext context, ProductoModel producto) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: _inputCategoriaController,
        enableInteractiveSelection: false,
        textCapitalization: TextCapitalization.sentences,
        // keyboardType: TextInputType.emailAddress,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        style: TextStyle(
          color: Colors.black,
        ),
        // toolbarOptions: ToolbarOptions(
          // copy: false,
          // cut: false,
          // paste: false,
          // selectAll: false
        // ),
        decoration: inputFormularios('Categoria Producto'),
        onTap: (){
          setState(() {
            FocusScope.of(context).requestFocus(new FocusNode());
            // _cargarCiudad(context);
            getCategorias(context);
            print('aqui');
            showModalBottomSheet(
              elevation: 16.0,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext bc){
                return Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  child: _cargarCategorias(context, producto),
                );
              }
            );
          });
        },
        validator: (value){
          if(value.isEmpty){
            return 'Selecione una ciudad';
          }else{
            return null;
          }
        },
        onSaved: (value){
          productoModificado.categoria.categoria = value.toString();
          // productoModificado.categoria.id = _idCategoria.toString();
        },
      )
    );
  }

  Widget _cargarCategorias(BuildContext context, ProductoModel producto){
    print('===');
    print(productoModelToJsonRegister(productoModificado));
    final bloc = Provider.of(context);
    return Column(
      children: [
        
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          // height: 20.0,
          child: Column(
            children: [
              SizedBox(height: 10.0,),
              Container(
                width: MediaQuery.of(context).size.width*0.5,
                height: 3.0,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(25.0)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Seleccione la categoria', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18.0),),
              )
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: bloc.listaCategoriasFormStream,
            builder: (BuildContext context, AsyncSnapshot<List<CategoriaModel>> snapshot){
              if(snapshot.hasData){
                return ListView(
                  children: [
                    for (CategoriaModel item in snapshot.data)
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(item.categoria),
                            onTap: (){
                              setState(() {
                                // bloc.cambiarCiudadesDirSink([]);
                                // _idCategoria = item.id;
                                productoModificado.categoria.id = item.id;
                                _inputCategoriaController.text = item.categoria;
                                Navigator.pop(context, false);
                              });
                            },
                            leading: item.id==productoModificado.categoria.id?Icon(Icons.check_box_rounded, color: Colors.green,):Icon(Icons.check_box_outline_blank),        
                          ),
                          Divider(),
                        ],
                      )
                    ,
                  ],
                );
              }else{
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator()
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  void _submitEliminar(BuildContext context, ProductoModel producto, PatronBloc bloc) async{
    try {
      setState(() {_isLoading = true;});
      // new Future.delayed(Duration(milliseconds: 1000), () {
        Map data = await _provideProducto.eliminarProducto(producto.id);
        // Map data = {'ok':true, 'code':401, 'titulo': 'Producto Eliminado', 'mensaje':'Se elimino de manera correcta el producto'};
        setState(() {_isLoading = false;});
        if(data['ok']){
          List<ProductoModel> eliminado = bloc.listaProductoEmitida;
          eliminado.removeWhere((item) => item.id == producto.id);
          bloc.cambiarListaProdcutoSink(eliminado);
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

  void _submitUpdate(BuildContext context, ProductoModel producto, PatronBloc bloc) async{
    try {
       if(_keyform.currentState.validate()){
        _keyform.currentState.save();
        print(productoModelToJsonRegister(productoModificado));
        setState(() {_isLoading = true;});
        // new Future.delayed(Duration(milliseconds: 1000), () {
          Map data = await _provideProducto.actualizarProducto(productoModificado);
          // Map data = {'ok':true, 'code':401, 'titulo': 'Producto Actualizado', 'mensaje':'Actualizamos el producto correctamente',
          //   'producto': { 'id': 8, 'nombre': 'Portatil 5', 'precio': 2000000, 'inventario': 39, 'categoria': {'id': 6, 'categoria': 'Tecnología'}}
          // };
          setState(() {_isLoading = false;});
          if(data['ok']){
            List<ProductoModel> lista = [];
            bloc.listaProductoEmitida.forEach((item){
              if(item.id==producto.id){
                lista.add(ProductoModel.fromJson(data['producto']));
              }else{
                lista.add(item);
              }
            });
            bloc.cambiarListaProdcutoSink(lista);
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

  void _iniciarDatos(ProductoModel producto) {
    if(iniciarDatos){
      iniciarDatos=false;
      _inputnNombreController.text = producto.nombre;
      _inputPrecioController.text = producto.precio;
      _inputInventarioController.text = producto.inventaria;
      _inputCategoriaController.text = producto.categoria.categoria;
    }
  }
}