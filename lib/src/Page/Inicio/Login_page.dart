import 'dart:async';
import 'package:flutter/material.dart';

import '../../Preferences/preferencias_usuario.dart';
import '../../Models/Usuario_model.dart';
import 'Class/inputFormaularios.dart';
import '../../Provider/usuario.dart';
import '../../Bloc/PatronBloc.dart';
import '../../Widgets/Loading.dart';
import '../../Widgets/Fondo.dart';
import '../../Bloc/Provider.dart';
import 'Class/Icon-titulo.dart';
import '../../Utils/Utils.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}
  
class _LoginPageState extends State<LoginPage> {
  
  final keyform = GlobalKey<FormState>();
  final _prefs = PreferenciasUsuario();
  final _provideUsuario = new UsuarioProvider();
  TextEditingController _inputEmailController = new TextEditingController();
  UsuarioModel _usuario = new UsuarioModel();

  FocusNode _focusCorreo = FocusNode();
  FocusNode _focuspass = FocusNode();

  bool _isSwitched = false;
  bool _passVisibility = false;
  bool _iniciarData = true;
  bool _isLoading = false;

  @override
  void initState() { 
    super.initState();
    _isSwitched = _prefs.guardarcorreo;
    // if(_isSwitched){
    //   _inputEmailController.text = _prefs.correo;
    // }
  }

  @override
  void dispose() { 
    _inputEmailController.dispose();
    _focusCorreo?.dispose();
    _focuspass?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _alertaSalir,
      child: Scaffold(
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
      ),
    );
  }

  Future<bool> _alertaSalir()async{
    if(Navigator.canPop(context)){
      Navigator.pop(context, true);
      return true;
    }else{
      return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          content: Text('¿Quieres salir de la aplicación?'),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancelar',)
            ),
            // ignore: deprecated_member_use
            FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              color: Colors.blue,
              onPressed: () => Navigator.pop(context, true),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Salir'),
                  SizedBox(width: 5.0,),
                  Icon(Icons.logout)
                ],
              )
            ),
          ],
        )
      );
    }
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconTitutlo(titulo: 'Iniciar Sesión', icon: Icons.person_pin, ),
          SizedBox(height: 40.0,),
          _formulario(context),
          SizedBox(height: 40.0,),
        ],
      ),
    );
  }

  Widget _formulario(BuildContext context) {
    final bloc = Provider.of(context);
    _iniciarDatos(context, bloc);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.white,
      shape: bordeRedondeado(),
      child: Column(
        children: [
          SizedBox(height: 20.0,),
          Form(
            key: keyform,
            child: Column(
              children: [
                SizedBox(height: 20.0,),
                _campoEmail(context, bloc),
                SizedBox(height: 10.0,),
                _password(context, bloc),
                // SizedBox(height: 0.0,),
                _campoSwitch(context),
                SizedBox(height: 5.0,),
                _botonEnviar(context, bloc),
                SizedBox(height: 30.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: Text('¿Aun no te has registrado? ',style: TextStyle(fontSize: 12.0, color: Colors.black),)),
                      GestureDetector(
                        onTap: (){
                          print('==${bloc.correoEmitido}');
                          bloc.cambiarpassFormSink('');
                          Navigator.pushReplacementNamed(context, 'register');
                        },
                        child: Text('Registrarme', style: TextStyle(fontSize: 12,color: Colors.blue, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),)
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
              ],
            ),
          ),
          SizedBox(height: 20.0,),
        ],
      ),
    );
  }

  Widget _campoEmail(BuildContext context, PatronBloc bloc) {
    return StreamBuilder(
      stream: bloc.correoFormStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            focusNode: _focusCorreo,
            controller: _inputEmailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_focuspass);
              _submit(context, bloc);
            },
            onChanged: bloc.cambiarCorreoFormSink,
            style: TextStyle(
              color: Colors.black,
            ),
            toolbarOptions: ToolbarOptions(
              copy: false,
              cut: false,
              paste: false,
              selectAll: false
            ),
            decoration: inputFormulariosStream('Correo Electronico', snapshot.error),
            validator: (value){
              if(value != ''){
                return null;
                // return 'No parece un correo valido';
              }else{
                return 'El correo no puede estar vacio';
              }
            },
            onSaved: (value){
              _usuario.email = value.toString();
            },
          ),
        );
      },
    );
  }

  Widget _campoSwitch(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Switch(

            value: _isSwitched,
            onChanged: (value){
              setState(() {
                _isSwitched=value;
                // print(isSwitched);
              });
            },
            activeTrackColor: Colors.lightBlueAccent,
            activeColor: Colors.blue,
          ),
          Text('Recordar Datos', style: TextStyle(color: Colors.black),)
        ],
      ),
    );
  }

  Widget _password(BuildContext context, PatronBloc bloc) {
    return StreamBuilder<Object>(
      stream: bloc.passFormStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            // controller: _inputEmailController,
            focusNode: _focuspass,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            onChanged: bloc.cambiarpassFormSink,
            onFieldSubmitted: (value) {
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
            obscureText: _passVisibility,
            // decoration: inputFormulariosStream('Constraseña', snapshot.error),
            decoration: InputDecoration(
              labelText: 'Constraseña',
              labelStyle: TextStyle(color: Colors.black),
              hoverColor: Colors.orange,
              filled: true,
              isDense: true,
              errorText: snapshot.error,
              suffixIcon: IconButton(

                icon: Icon(
                  _passVisibility
                    ? Icons.visibility
                    : Icons.visibility_off,
                  color: Colors.black54,
                ),
                color: Colors.black,
                onPressed: () {
                  setState(() => _passVisibility = !_passVisibility);
                },
              ),
              focusedBorder: decoracion(Colors.black, 1.0, 25.0),
              disabledBorder: decoracion(Colors.black, 1.0, 25.0),
              enabledBorder: decoracion(Colors.black, 1.0, 25.0),
              border: decoracion(Colors.transparent, 1.0, 25.0),
              errorBorder: decoracion(Colors.red, 1.0, 25.0),
              focusedErrorBorder: decoracion(Colors.red, 1.0, 25.0),
            ),

            // validator: (value){
            //   if(value != ''){
            //     return null;
            //   }else{
            //     return 'Contraseña requerida';
            //   }
            // },
            onSaved: (value){
              _usuario.password = value.toString();
            },
          ),
        );
      }
    );
  }

  Widget _botonEnviar(BuildContext context, PatronBloc bloc) {
    return StreamBuilder<Object>(
      stream: bloc.formLoginStrem,
      builder: (context, snapshot) {
        print('==% ${snapshot.data}');
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).orientation==Orientation.landscape? 100.0: 20.0),
          // ignore: deprecated_member_use
          child: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
            onPressed: snapshot.hasData
            ?(){
              FocusScope.of(context).unfocus();
              _submit(context, bloc);
            }
            :null,
            // onPressed: (){
            //   _submit(context);
            // },
            textColor: Colors.white,
            color: Colors.blue[500],
            padding: const EdgeInsets.all(0.0),
            child: Container(
              child: Center(
                child: Text('Ingresar')
              ),
            ),
          ),
        );
      }
    );
  }

  void _submit(BuildContext context, PatronBloc bloc) async{
    try {
      if(keyform.currentState.validate()){
        keyform.currentState.save();
        setState(() {_isLoading = true;});
        print(usuarioModelToJsoLogin(_usuario));
        // new Future.delayed(Duration(milliseconds: 5000), () {
          Map data = await _provideUsuario.login(_usuario);
          // Map data = {'ok':true, 'code':201, 'user': {"firsname": "pepito", "lastname": "Perez", "email": "quicenojuan996@gmail.com"}};
          setState(() {_isLoading = false;});
          if(data['ok']){
            if(_isSwitched){
              _prefs.guardarcorreo = _isSwitched;
              _prefs.correo = _usuario.email;
            }
            _prefs.ultimaPagina = 'login';
            bloc.cambiarUsuarioSink(UsuarioModel.fromJson(data['user']));
            Navigator.of(context).pushNamedAndRemoveUntil('dashboard', (Route<dynamic> route) => false);
          }else{
            if(data['code']==400||data['code']==401){
              alertaErrorConexion(context, '${data['titulo']}', '${data['mensaje']}');
            }else{
              alertaErrorConexion(context, 'Problemas en la verificación', 'Parece que no se completo el registro');
            }
          }
        // });
      }
    }catch(general){
      Navigator.of(context).pushNamedAndRemoveUntil('dashboard', (Route<dynamic> route) => false);
      setState(() {_isLoading = false;});
      alertaErrorConexion(context, 'Upss','No se pudo establecer conexion con el servidor, intente nuevamente');
      //===================== descomentar para pruebas 
      //*****************************
        // Map data = {'ok':true, 'code':201, 'user': {"firsname": "pepito", "lastname": "Perez", "email": "quicenojuan996@gmail.com"}};
        // _prefs.ultimaPagina = 'login';
        // bloc.cambiarUsuarioSink(UsuarioModel.fromJson(data['user']));
      //*****************************
    }
  }

  void _iniciarDatos(BuildContext context, PatronBloc bloc) {
    if(_iniciarData){
      _iniciarData=false;
      try {
        if(bloc.correoEmitido!=null){
          _inputEmailController.text = bloc.correoEmitido;
          print('bloc asignado');
        }
        print('es nulo');
      } catch (e) {
        print('error bloc');
      }
      if(_isSwitched){
        bloc.cambiarCorreoFormSink(_prefs.correo);
         _inputEmailController.text = bloc.correoEmitido;
      }     
      setState(() {
      });
    }
  }
}