import 'package:flutter/material.dart';
import 'package:stars/models/genres_model.dart';
import 'package:stars/models/now_playing_model.dart';
import 'package:stars/services/movies_service.dart';

class MoviesProvider extends ChangeNotifier {
  List<Result> nowPlaying = [];
  List<Result> popularMovies = [];
  List<Result> topRated = [];
  List<Result> upcoming = [];
  List<Genre> genres = [];

  MoviesService service = MoviesService();
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<List<Result>> getNowPlaying() async {
    nowPlaying = await service.getListNowPlaying();
    _isLoading = false;
    notifyListeners();
    return nowPlaying;
  }

  Future<List<Result>> getPopularMovies() async {
    popularMovies = await service.getPopularMovies();
    _isLoading = false;
    notifyListeners();
    return popularMovies;
  }

  Future<List<Result>> getTopRated() async {
    topRated = await service.getTopRated();
    _isLoading = false;
    notifyListeners();
    return topRated;
  }

  Future<List<Result>> getUpcoming() async {
    upcoming = await service.getUpcoming();
    _isLoading = false;
    notifyListeners();
    return upcoming;
  }

  Future<List<Genre>> getGenres() async {
    genres = await service.getGenres();
    _isLoading = false;
    notifyListeners();
    return genres;
  }
}
