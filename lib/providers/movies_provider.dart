import 'package:flutter/material.dart';
import 'package:stars/models/credits_model.dart';
import 'package:stars/models/genres_model.dart';
import 'package:stars/models/movie_detail_model.dart';
import 'package:stars/models/now_playing_model.dart';
import 'package:stars/services/movies_service.dart';

class MoviesProvider extends ChangeNotifier {
  List<Result> nowPlaying = [];
  List<Result> popularMovies = [];
  List<Result> topRated = [];
  List<Result> upcoming = [];
  List<Genre> genres = [];
  MovieDetail details = MovieDetail();
  List<Cast> castList = [];

  MoviesService service = MoviesService();
  bool _isLoading = true;
  int _page = 0;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  getNowPlaying() async {
    _page++;
    List<Result> result = await service.getListNowPlaying(_page);
    nowPlaying = [...nowPlaying, ...result];
    _isLoading = false;
    notifyListeners();
  }

  getPopularMovies() async {
    _page++;
    List<Result> result = await service.getPopularMovies(_page);
    popularMovies = [...popularMovies, ...result];
    _isLoading = false;
    notifyListeners();
  }

  getTopRated() async {
    _page++;
    List<Result> result = await service.getTopRated(_page);
    topRated = [...topRated, ...result];
    _isLoading = false;
    notifyListeners();
  }

  getUpcoming() async {
    _page++;
    List<Result> result = await service.getUpcoming(_page);
    upcoming = [...upcoming, ...result];
    _isLoading = false;
    notifyListeners();
  }

  Future<List<Genre>> getGenres() async {
    genres = await service.getGenres();
    _isLoading = false;
    notifyListeners();
    return genres;
  }

  Future<MovieDetail> getDetails(String id) async {
    details = await service.getDetails(id);
    _isLoading = false;
    notifyListeners();
    return details;
  }

  Future<List<Cast>> getCast(String id) async {
    castList = await service.getCast(id);
    _isLoading = false;
    notifyListeners();
    return castList;
  }
}
