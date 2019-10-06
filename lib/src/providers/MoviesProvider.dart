import 'dart:convert';

import 'package:app_peliculas/src/models/Movie.dart';
import 'package:http/http.dart' as http;
class MoviesProvider{
  String _apikey="38da7698b291b6c8c867362bd258c67e";
  String _url="api.themoviedb.org";
  String _language="es-Es";

  Future<List<Movie>>getNowPlaying() async{
   final url=Uri.https(_url,'3/movie/now_playing',{
     'api_key':_apikey,
     'language':_language
   });
    final response=await http.get(url);
    final decodedData=json.decode(response.body);
    final moviesDecoded=new Movies.fromJsonList(decodedData['results']);
    return moviesDecoded.movies;
  }
}