import 'package:flutter/material.dart';
import 'package:peliculas/src/misWidgets/card_swiper.dart';
import 'package:peliculas/src/misWidgets/movie_horizontal.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    //final _screenSize = MediaQuery.of(context).size;
    //print(_screenSize);
    peliculasProvider.getPopulares();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        //backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
                //query: 'hi'
                );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      )
       
    );
  }

  Widget _swiperTarjetas(/* BuildContext context */) {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        
        if ( snapshot.hasData ) {
          return CardSwiper( peliculas: snapshot.data );
        } else {
          return Container(
            height: 300.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
        
      },
    );

    /* peliculasProvider.getEnCines();
    
    return CardSwiper(peliculas: [1,2,3,4,5],); */
  }

  Widget _footer(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      //color: Colors.blue,
      height: _screenSize.height*0.35,
      //width: double.infinity,
      child: //Text("data")
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //color: Colors.yellow,
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(height: 10.0),
          StreamBuilder(
              stream: peliculasProvider.popularesStream,
              //initialData: [],
              builder: (BuildContext context,
                  AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return VistaHorixontalPeliculas(
                    peliculas: snapshot.data,
                    siguientePagina: peliculasProvider.getPopulares,
                    );
                } else {
                  return Container(
                      height: 700.0,
                      child: Center(child: CircularProgressIndicator()));
                }
              }),
        ],
      ),
    );
  }
}
