import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculaModel.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final proveedorPeliculas = new PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam',
    'Ironman',
    'Capitan America'
  ];
  final peliculasRecientes = ['Spiderman', 'Capitan america'];

  String seleccion = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    // aciones del appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del appbar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados a mostrar
    return Text("data");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // con las sugerencias cuando la persona escribe

    if (query.isEmpty) {
      Container();
    }

    return FutureBuilder(
        future: proveedorPeliculas.buscarPelicula(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data;
            return ListView(
              children: peliculas.map((pelicula) {
                return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(pelicula.getPosterImg()),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  onTap: () {
                    close(context, null);
                    Navigator.pushNamed(context, 'detalle',
                        arguments: pelicula);
                  },
                );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
