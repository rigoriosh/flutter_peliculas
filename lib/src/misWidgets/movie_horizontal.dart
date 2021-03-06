import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculaModel.dart';

class VistaHorixontalPeliculas extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  VistaHorixontalPeliculas(
      {Key key, @required this.peliculas, @required this.siguientePagina})
      : super(key: key);

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _tamanioPantalla = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        print('Cargar siguientes peliculas');
        //siguientePagina();
      }
    });

    return Container(
        //color: Colors.blueGrey,
        height: _tamanioPantalla.height * 0.25,
        child: PageView.builder(
          //children: _tarjetas(context),
          pageSnapping: false,
          controller: _pageController,
          itemCount: peliculas.length,
          itemBuilder: (BuildContext context, int i) =>
              _tarjeta(peliculas[i], context),
        ));
  }

  Widget _tarjeta(pelicula, BuildContext context) {
    final _tamanioPantalla = MediaQuery.of(context).size;
    final tarjeta = Container(
      //color: Colors.blue,
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Hero(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: _tamanioPantalla.height * 0.22,
              ),
            ),
            tag: pelicula.id,
          ),
          SizedBox(height: 5.0),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
        child: tarjeta,
        onTap: () {
          print("oprimida la ${pelicula.title}");
          Navigator.pushNamed(context, 'detalle',
              arguments:
                  pelicula); //sedirege a la ruta 'detalle' y llava argumentos.
        });
  }

  /* List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      final _tamanioPantalla = MediaQuery.of(context).size;
      return Container(
        //color: Colors.blue,
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: _tamanioPantalla.height * 0.22,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  } */
}
