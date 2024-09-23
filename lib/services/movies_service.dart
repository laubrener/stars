import 'dart:convert';

import 'package:stars/auth/secrets.dart';
import 'package:stars/models/genres_model.dart';
import 'package:stars/models/now_playing_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class MoviesService {
  Future<List<Result>> getListNowPlaying() async {
    Uri url = Uri.parse(
        '$path/3/movie/now_playing?api_key=$apiKey&language=$lang&page=1');
    Response resp = await http
        .get(url, headers: {'Content-Type': 'application/json;charset=UTF-8'});

    ListNowPlaying nowPlaying =
        ListNowPlaying.fromRawJson(utf8.decode(resp.bodyBytes));
    List<Result> moviesList = nowPlaying.results ?? [];

    return moviesList;
  }

  Future<List<Result>> getPopularMovies() async {
    Uri url = Uri.parse(
        '$path/3/movie/popular?api_key=$apiKey&language=$lang&page=1');
    Response resp = await http
        .get(url, headers: {'Content-Type': 'application/json;charset=UTF-8'});

    ListNowPlaying nowPlaying =
        ListNowPlaying.fromRawJson(utf8.decode(resp.bodyBytes));
    List<Result> moviesList = nowPlaying.results ?? [];

    return moviesList;
  }

  Future<List<Result>> getTopRated() async {
    Uri url = Uri.parse(
        '$path/3/movie/top_rated?api_key=$apiKey&language=$lang&page=1');
    Response resp = await http
        .get(url, headers: {'Content-Type': 'application/json;charset=UTF-8'});

    ListNowPlaying nowPlaying =
        ListNowPlaying.fromRawJson(utf8.decode(resp.bodyBytes));
    List<Result> moviesList = nowPlaying.results ?? [];

    return moviesList;
  }

  Future<List<Result>> getUpcoming() async {
    Uri url = Uri.parse(
        '$path/3/movie/upcoming?api_key=$apiKey&language=$lang&page=1');
    Response resp = await http
        .get(url, headers: {'Content-Type': 'application/json;charset=UTF-8'});

    ListNowPlaying nowPlaying =
        ListNowPlaying.fromRawJson(utf8.decode(resp.bodyBytes));
    List<Result> moviesList = nowPlaying.results ?? [];

    return moviesList;
  }

  Future<List<Genre>> getGenres() async {
    Uri url =
        Uri.parse('$path/3/genre/movie/list?api_key=$apiKey&language=$lang');
    Response resp = await http
        .get(url, headers: {'Content-Type': 'application/json;charset=UTF-8'});

    GenresList result = GenresList.fromRawJson(utf8.decode(resp.bodyBytes));
    List<Genre> genresList = result.genres ?? [];

    return genresList;
  }
}
