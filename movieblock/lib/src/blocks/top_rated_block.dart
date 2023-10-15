import '../resources/repository.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/streams.dart';
import '../models/item_model.dart';

class TopRatedBloc{
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();

  Stream<ItemModel> get topRated => _moviesFetcher.stream;

  Future<void> fetchTopRatedMovies() async{
    ItemModel itemModel = await _repository.fetchTopRatedMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  void dispose(){
    _moviesFetcher.close();
  }

}

final topRatedBloc = TopRatedBloc();