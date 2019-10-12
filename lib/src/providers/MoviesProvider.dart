import 'dart:async';
import 'dart:convert';

import 'package:app_peliculas/src/models/Actor.dart';
import 'package:app_peliculas/src/models/Movie.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apikey = "38da7698b291b6c8c867362bd258c67e";
  String _url = "api.themoviedb.org";
  String _language = "es-Es";
  int _popularesPage = 0;
  bool _loading = false;
  List<Movie> _popular = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disponseStreams() {
    _popularStreamController?.close();
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});
    return await _processResponse(url);
  }

  Future<List<Movie>> getPopular() async {
    if (_loading) return [];
    _loading = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final response = await _processResponse(url);

    _popular.addAll(response);
    popularSink(_popular);
    _loading = false;
    return response;
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final moviesDecoded = new Movies.fromJsonList(decodedData['results']);
    return moviesDecoded.movies;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final cast = Cast.fromJsonList(decodedData['cast']);
    return cast.actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': query});
    return await _processResponse(url);
  }
}
