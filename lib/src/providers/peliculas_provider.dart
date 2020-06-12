
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_models.dart';
import 'package:peliculas/src/models/peliculaModel.dart';

class PeliculasProvider{
  String _apiKey           = '1865f43a0549ca50d341dd9ab8b29f49';
  String _url              = 'api.themoviedb.org';
  String _language         = 'es-ES';
  String _getUrlEnCines    = '3/movie/now_playing';
  String _getUrlPopulares  = '3/movie/popular'; 
  int _popularesPage = 0;
  bool _cargandoPeliculas = false;
  List<Pelicula> _populares = new List();
  final _popularesStreamControler = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamControler.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamControler.stream;

  void disposeStreams(){
    _popularesStreamControler?.close();// el ? es para saber si el metodo tiene el metodo close, si no es asi no haga nada.
    }

  Future<List<Pelicula>> _procesarTespuesta(Uri url) async {
    final respuesta = await http.get(url);
    final decodeData = json.decode(respuesta.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);
    return peliculas.itemPelicula;
  }

  Future <List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, _getUrlEnCines,{
      'api_key' :_apiKey,
      'language':_language,
      //'page'    :,
      //'region'  :,
    });

    return await _procesarTespuesta(url);
     
  }

  Future<List<Pelicula>> getPopulares() async{
    
    if (_cargandoPeliculas) return [];
    _cargandoPeliculas = true;
    _popularesPage++;
    print('Cargando siguientes .....');
    final url = Uri.https(_url, _getUrlPopulares,{
      'api_key' :_apiKey,
      'language':_language,
      'page': _popularesPage.toString(),
    });

    final resp = await _procesarTespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    _cargandoPeliculas = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async{
    final url = Uri.https(_url, '3/movie/$peliId/credits',{
      'api_key' :_apiKey,
      'language':_language,
    });
    final resp = await http.get(url);
    final decodedDate = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedDate['cast']);
    return cast.actores;
  }

  Future <List<Pelicula>> buscarPelicula(String query) async{
    final url = Uri.https(_url, '3/search/movie',{
      'api_key' : _apiKey,
      'language': _language,
      'query'   : query 
    });

    return await _procesarTespuesta(url);
     
  }

}