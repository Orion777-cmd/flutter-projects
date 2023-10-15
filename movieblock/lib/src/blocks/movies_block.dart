import '../resources/repository.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/streams.dart';
import '../models/item_model.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();

  Stream<ItemModel> get allMovies => _moviesFetcher.stream;

  Future<void> fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  void dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();
