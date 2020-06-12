import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/peliculaModel.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas; //listado de todas las peliculas a mostrar

  CardSwiper({@required this.peliculas}); // aqui recibe las peliculas

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.only(top: 10.0),
        //color: Colors.red,
        height: _screenSize.height * 0.5,
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.9,
          itemBuilder: (BuildContext context, int index) {
            //for q se ejecta itemCount veces, para crear cada tarjetas\
            peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';
            return Hero(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'detalle',
                          arguments: peliculas[index]); //sedirege a la ruta 'detalle' y llava argumentos.
                    },
                    child: FadeInImage(
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      image: NetworkImage(peliculas[index].getPosterImg()),
                      fit: BoxFit.cover,
                    ),
                  ),
                  /* Image.network(
                  'https://image.tmdb.org/t/p/original/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg',
                  fit: BoxFit.cover ,
                ), */
                ),
                tag: peliculas[index].uniqueId);
          },
          itemCount: peliculas.length,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
        ));
  }
}

//1865f43a0549ca50d341dd9ab8b29f49

// endPoint
//https://api.themoviedb.org/3/movie/now_playing?api_key=1865f43a0549ca50d341dd9ab8b29f49&language=en-US&page=1
