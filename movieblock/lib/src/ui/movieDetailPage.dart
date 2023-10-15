import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocks/movie_detail.dart';

class MovieDetailPage extends StatefulWidget {
  final Result movie;

  MovieDetailPage({required this.movie});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final MovieDetailBloc _movieDetailBloc = MovieDetailBloc();

  @override
  void initState() {
    super.initState();
    if (widget.movie.id != null) {
      _movieDetailBloc.fetchMovieDetail(widget.movie.id!);
    }
  }

  @override
  void dispose() {
    _movieDetailBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title ?? ''),
        actions: [
          IconButton(  
            icon: const Icon(Icons.search),
            onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(  
                const SnackBar(  
                  content: Text('search for movies'),
                )
              );
            },
          )
        ],
      ),
      body: StreamBuilder<Result?>(
        stream: _movieDetailBloc.movieDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return buildMovieDetail(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildMovieDetail(Result movie) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/original/${movie.posterPath}',
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title ?? '',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Release Date: ${movie.releaseDate ?? ''}',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Vote Average: ${movie.voteAverage ?? 0.0}',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  movie.overview ?? '',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0,),
                Text(  
                  'Popularity: ${movie.popularity?? 0.0}',
                  style: TextStyle(fontSize: 16.0)

                ),
                SizedBox(height: 16.0),
                

              ],
            ),
          ),
        ],
      ),
    );
  }
}
