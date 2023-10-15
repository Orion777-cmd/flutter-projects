import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '662fc0b6b2c4cd7aed7ac90dac08280d';

  Future<ItemModel> fetchMovieList() async {
    print('entered');
    final response = await client.get(
      Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey'),
    );
    print(response.body.toString());
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Result> fetchMovieDetail(int movieId) async { // Change the return type here
    print('movieID: $movieId');
    final url = Uri.parse('https://api.themoviedb.org/3/movie/$movieId?api_key=$_apiKey');

    final response = await client.get(url);
    print(response.body.toString());
    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body);
      if (parsedJson != null) {
        return Result.fromJson(parsedJson); // Change the return type here
      } else {
        throw Exception('Failed to parse movie detail');
      }
    } else {
      throw Exception('Failed to fetch movie detail');
    }
  }

  Future<ItemModel> searchMovie(String query) async{
    print('query: $query' );
    final url = Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&query=$query');
    print('uphere');
    final response = await client.get(url);
    print(response.body.toString());
    if (response.statusCode == 200){
      final parsedJson = json.decode(response.body);
      print('how about here');
      if (parsedJson != null){
        return ItemModel.fromJson(parsedJson);
        
      }else{
        throw Exception('Failed to parse movie');
      }
    }else{
      throw Exception('Failed to get the searched movie');
    }
  }

  Future<ItemModel> fetchTopRatedMovies() async{
    print('entered');
    final response = await client.get(  
      Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=${_apiKey}')
    );
    print(response.body.toString());
    if(response.statusCode == 200){
      final decodedResponse = json.decode(response.body);
      return ItemModel.fromJson(decodedResponse);
    }else{
      throw Exception('Failed to get the top rated movies');
    }
  }
}
