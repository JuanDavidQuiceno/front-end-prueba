import 'package:flutter/material.dart';
import '../../../Bloc/Provider.dart';
import '../../../Models/Categoria_model.dart';
import '../../../Models/Producto_model.dart';
import '../../../Page/Inicio/Class/Icon-titulo.dart';
import '../../../Page/Inicio/Class/inputFormaularios.dart';
import '../../../Page/dashboard/Class/getCategorias.dart';
import '../../../Provider/Producto.dart';
import '../../../Utils/Utils.dart';
import '../../../Widgets/Fondo.dart';
import '../../../Widgets/Loading.dart';

class AddProductPage extends StatefulWidget {

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  
  final _keyform = GlobalKey<FormState>();
  final _providerProducto = new ProductoProvider();
  ProductoModel _producto = new ProductoModel();

  TextEditingController _inputCategoriaController = new TextEditingController();

  FocusNode _focusNombre = FocusNode();
  FocusNode _focusprecio = FocusNode();
  FocusNode _focusinventario = FocusNode();
  // FocusNode _focuscategoria = FocusNode();
  String idCategoria = '';

  bool _isLoading = false;

  @override
  void initState() { 
    super.initState();
    _producto = ProductoModel.fromJson({
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
    _inputCategoriaController?.dispose();
    _focusNombre?.dispose();
    _focusprecio?.dispose();
    _focusinventario?.dispose();
    // _focuscategoria?.dispose();
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
          IconTitutlo(titulo: 'Crear Producto', icon: Icons.data_usage_outlined, ),
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
                 SizedBox(height: 10.0,),
                _campoPrecio(context),
                SizedBox(height: 10.0,),
                _campoInventario(context),
                SizedBox(height: 10.0,),
                _campoCategoria(context),
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
        focusNode: _focusNombre,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_focusprecio);
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
          _producto.nombre = value.toString();
        },
      ),
    );
  }

  Widget _campoPrecio(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        focusNode: _focusprecio,
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
          _producto.precio = value.toString();
        },
      ),
    );
  }

  Widget _campoInventario(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        focusNode: _focusinventario,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          // FocusScope.of(context).requestFocus(_focuscategoria);
          FocusScope.of(context).unfocus();
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
        decoration: inputFormularios('Inventario Producto'),
        validator: (value){
          if(value != ''){
            return null;
            // return 'No parece un correo valido';
          }else{
            return 'Campo debe contener un nombre';
          }
        },
        onSaved: (value){
          _producto.inventaria = value.toString();
        },
      ),
    );
  }

  Widget _campoCategoria(BuildContext context) {
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
                  child: _cargarCiudades(context),
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
          _producto.categoria.categoria = value.toString();
          _producto.categoria.id = idCategoria.toString();
        },
      )
    );
  }

  Widget _cargarCiudades(BuildContext context){
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
                                idCategoria = item.id;
                                _inputCategoriaController.text = item.categoria;
                                Navigator.pop(context, false);
                              });
                            },
                            leading: item.id==idCategoria.toString()?Icon(Icons.check_box_rounded, color: Colors.green,):Icon(Icons.check_box_outline_blank),        
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

  Widget _botonEnviar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).orientation==Orientation.landscape? 100.0: 20.0),
      // ignore: deprecated_member_use
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
            child: Text('Crear Producto')
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
        print(productoModelToJsonRegister(_producto));
        setState(() {_isLoading = true;});
        // new Future.delayed(Duration(milliseconds: 1000), () {
          Map data = await _providerProducto.crearProducto(_producto);
          // Map data = {'ok':true, 
          //   'code':201, 
          //   'titulo': 'Producto Actualizado', 
          //   'mensaje':'Actualizamos el producto correctamente',
          //   'productos': [
          //     {'id': 8,   'nombre': 'Portatil 8', 'precio': 1000000, 'inventario': 49, 'categoria': {'id': 6, 'categoria': 'Tecnología'}},
          //     {'id': 9, 'nombre': 'Portatil 9', 'precio': 1000000, 'inventario': 49, 'categoria': {'id': 7, 'categoria': 'Vehiculos'}},
          //     {'id': 10,'nombre': 'Portatil 10','precio': 1000000, 'inventario': 49, 'categoria': {'id': 7, 'categoria': 'Vehiculos'}},
          //   ]
          // };
          setState(() {_isLoading = false;});
          if(data['ok']){
            List listado = data['productos'];
            List<ProductoModel> _listaProducto = [];
            if(listado.isNotEmpty){
              listado.forEach((element) {
                _listaProducto.add(ProductoModel.fromJson(element));
              });
              bloc.cambiarListaProdcutoSink(_listaProducto);
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