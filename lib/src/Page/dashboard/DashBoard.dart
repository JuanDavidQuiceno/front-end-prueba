import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:prueba_tecnica/src/Page/dashboard/Categorias_page.dart';
import 'package:prueba_tecnica/src/Page/dashboard/Perfil_page.dart';
import 'package:prueba_tecnica/src/Page/dashboard/Productos_page.dart';

class DashboardPage extends StatefulWidget {

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _alertaSalir,
      child: Scaffold(
        body: _panel(context),
        bottomNavigationBar: _buildNotificationBadge(context),
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
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          content: Text('Antes de salir de la aplicación le recomendamos cerrar la sesión'),
          actions: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancelar',)
            ),
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

  Widget _panel(BuildContext context){
    return _currentIndex == 0
      ?ProductosPage()
      : _currentIndex ==1 
        ?CategoriasPage()
        :PerfilPage();
  }

  Widget _buildNotificationBadge(BuildContext context) {
    return CustomNavigationBar(
      selectedColor: Colors.blue,
      strokeColor: Colors.blue,
      unSelectedColor: Color(0xffacacac),
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon: Center(child: Icon(Icons.data_usage_outlined)),
          title: Text('Productos', style: TextStyle(fontSize: 7.0 ,color: _currentIndex == 0?Colors.blue:Color(0xffacacac)), overflow: TextOverflow.ellipsis,),

        ),
        CustomNavigationBarItem(
          icon: Center(child: Icon(Icons.widgets_rounded)),
          title: Text('Categorias', style: TextStyle(fontSize: 7.0 ,color: _currentIndex == 1?Colors.blue:Color(0xffacacac)),overflow: TextOverflow.ellipsis,),
        ),
        CustomNavigationBarItem(
          icon: Center(child: Icon(LineIcons.user,)),
          badgeCount: 0,
          showBadge: false,
          title: Text('Cuenta', style: TextStyle(fontSize: 7.0 ,color: _currentIndex == 2?Colors.blue:Color(0xffacacac)),),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}