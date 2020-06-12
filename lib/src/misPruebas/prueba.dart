import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/directions_page.dart';
import 'package:peliculas/src/pages/inicio_page.dart';
import 'package:peliculas/src/pages/mapas_page.dart';

class Prueba extends StatefulWidget {
  @override
  _PruebaState createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
  int paginaActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
                child: Icon(Icons.movie),
                //mini: true,
                //clipBehavior: Clip.antiAlias,
                onPressed: () {
                  print("object");
                  Navigator.pushNamed(context, 'inicio');
                }),
          ],
        ),
      ),
      
    );
  }
}
