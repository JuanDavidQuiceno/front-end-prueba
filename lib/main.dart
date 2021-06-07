import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/Page/dashboard/VistaDetalles/AddCategory_page.dart';
import 'src/Page/dashboard/VistaDetalles/AddProduct_page.dart';
import 'src/Page/dashboard/VistaDetalles/DetalleCategory_page.dart';
import 'src/Page/dashboard/VistaDetalles/DetalleProduct_page.dart';
import 'src/Preferences/preferencias_usuario.dart';
import 'src/Page/Inicio/registre_page.dart';
import 'src/SplashScreen/SplashScreen.dart';
import 'src/Page/dashboard/DashBoard.dart';
import 'src/Page/Inicio/Inicio_page.dart';
import 'src/Page/Inicio/Login_page.dart';
import 'src/Bloc/Provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();  
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.blue[900]
    )
  );    
  //============= Orientacion vertical
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> _keyGlobal = new GlobalKey<NavigatorState>();

  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        navigatorKey: _keyGlobal,
        debugShowCheckedModeBanner: false,
        title: 'Prueba Tecnica',
        initialRoute:  'splash',
        home: SplashScreen(),
        routes: {
          'splash' : (BuildContext context) => SplashScreen(),
          'inicio' : (BuildContext context) => InicioPage(),
          'login'  : (BuildContext context) => LoginPage(),
          'register' : (BuildContext context) => RegisterPage(),
          'dashboard' : (BuildContext context) => DashboardPage(),
          'detalle_product' : (BuildContext context) => DetalleProductPage(),
          'detalle_category' : (BuildContext context) => DetalleCategoryPage(),
          'add_product' : (BuildContext context) => AddProductPage(),
          'add_category' : (BuildContext context) => AddCategoryPage(),
        },
        theme: new ThemeData(
          primarySwatch: Colors.blue,
          primaryIconTheme: IconThemeData(
            color: Colors.white,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // localizationsDelegates: [
        //   // ... delegado[s] de localización específicos de la app aquí
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        // supportedLocales: [
        //   const Locale('es'), // Español
        //   const Locale('en'), // Inglés
        // ],
      ),
    );
  }


}