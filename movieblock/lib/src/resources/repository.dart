import 'dart:async';
import 'movie_api_provider.dart';
import '../models/item_model.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();

  Future<Result> fetchMovieDetail(int movieId) =>
      moviesApiProvider.fetchMovieDetail(movieId);

  Future<ItemModel> fetchTopRatedMovies() => moviesApiProvider.fetchTopRatedMovies();

  Future<ItemModel> searchMovie(String query) => moviesApiProvider.searchMovie(query);
}
