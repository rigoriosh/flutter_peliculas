

import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/directions_page.dart';
import 'package:peliculas/src/pages/mapas_page.dart';

class PaginaInicio extends StatefulWidget {
  const PaginaInicio({Key key}) : super(key: key);

  @override
  _PaginaInicioState createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio> {
  
  int paginaActual = 10;
  @override
  Widget build(BuildContext context) {
    print("dddd");
    return Scaffold(
      body: _cargarPagina(paginaActual),
      bottomNavigationBar: _creacionBTNnavigation(),     
    );
  }

  Widget _creacionBTNnavigation() {


    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index){
        setState(() {
          print("object");
          paginaActual = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Directins')
          ),
          
      ],
      );
  }

  Widget _cargarPagina(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return PaginaMapa();
        break;
      case 1:
        return PaginaDirectios();
        break; 
      default: return PaginaInicio();
    }
  }
}