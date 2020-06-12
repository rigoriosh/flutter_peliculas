import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/detalle_pelicula.dart';
import 'package:peliculas/src/pages/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: "dddd",
      initialRoute: '/',
      routes: {
        //'QR': (BuildContext context) => PaginaInicio(),
        // '/': (BuildContext context) => Aplicacion1(),
        // 'inicio': (BuildContext context) => Prueba(),
        '/': (BuildContext context) => HomePage(),
        //'/': (BuildContext context) => Prueba(),
        //'inicio': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => DetallePelicula() 
      },
    );
  }
}



