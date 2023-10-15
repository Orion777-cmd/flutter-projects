import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'movieDetailPage.dart';
import '../blocks/search_movie.dart';

class MovieSearchScreen extends StatefulWidget {
  final TextEditingController searchController;

  const MovieSearchScreen({Key? key, required this.searchController})
      : super(key: key);

  @override
  _MovieSearchScreenState createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_onSearchChanged);
    searchMovieBloc.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    searchMovieBloc.searchMovie(widget.searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: widget.searchController,
          decoration: InputDecoration(
            hintText: 'Search movies...',
            border: InputBorder.none,
          ),
          onChanged: (value) => _onSearchChanged(),
        ),
      ),
      body: StreamBuilder<ItemModel>(
        stream: searchMovieBloc.searchedMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildSearchResults(snapshot);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error.toString()}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildSearchResults(AsyncSnapshot<ItemModel> snapshot) {
    final List<Result> movies = snapshot.data?.results ?? [];

    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        final movie = movies[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://image.tmdb.org/t/p/original/${movie.posterPath}',
            ),
          ),
          title: Text(movie.title ?? ''),
          subtitle: Row(
            children: [
              Icon(Icons.star, color: Colors.yellow),
              Text('${(movie.voteAverage ?? 0).toStringAsFixed(1)}'),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(movie: movie),
              ),
            );
          },
        );
      },
    );
  }
}
