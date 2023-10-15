import '../models/item_model.dart';
import '../resources/repository.dart';
import 'package:rxdart/subjects.dart';

class MovieDetailBloc {
  final _repository = Repository();
  final _movieFetcher = PublishSubject<Result>(); // Change the type here

  Stream<Result> get movieDetail => _movieFetcher.stream; // Update the return type

  Future<void> fetchMovieDetail(int movieId) async {
    Result movie = (await _repository.fetchMovieDetail(movieId)) as Result; // Change the type here
    _movieFetcher.sink.add(movie);
  }

  void dispose() {
    _movieFetcher.close();
  }
}

final movieDetailBloc = MovieDetailBloc();
