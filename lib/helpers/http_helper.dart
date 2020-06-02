import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:merchant/models/movie_model.dart';

final String urlKey = 'api_key=2a942e88d3ffdc6a0f8906592c9035c8';
final String urlBase = 'https://api.themoviedb.org/3/movie';
final String urlUpcoming = '/upcoming?';
final String urlLanguage = '&language=en-US';
final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;
final String urlSearchBase =
    'https://api.themoviedb.org/3/search/movie?api_key=2a942e88d3ffdc6a0f8906592c9035c8&query=';

class HttpHelper {
  Future<List> getUpcoming() async {
    http.Response result = await http.get(upcoming);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }

  Future<List> findMovies(String title) async {
    final String query = urlSearchBase + title;
    http.Response result = await http.get(query);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((mv) => Movie.fromJson(mv)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
