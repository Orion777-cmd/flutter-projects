import '../resources/repository.dart';
import 'package:rxdart/subjects.dart';
import '../models/item_model.dart';

class SearchMovieBloc {
  final _repository = Repository();
  final _searchedMovies = PublishSubject<ItemModel>();

  Stream<ItemModel> get searchedMovies => _searchedMovies.stream;

  Future<void> searchMovie(String query) async {
    ItemModel result = await _repository.searchMovie(query);
    _searchedMovies.sink.add(result);
  }

  void dispose() {
    _searchedMovies.close();
  }
}

final searchMovieBloc = SearchMovieBloc();
