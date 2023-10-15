import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocks/movies_block.dart';
import 'movieDetailPage.dart';
import 'search_screen.dart';

class MovieList extends StatefulWidget {
  final VoidCallback updateAppBarTitle; // Callback function to update the title

  const MovieList({Key? key, required this.updateAppBarTitle}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Popular Movies'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.search),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => MovieSearchScreen(
      //               searchController: TextEditingController(),
      //               onSearch: (query) {
      //                 // Perform search logic here
      //               },
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.results.length,
      itemBuilder: (BuildContext context, int index) {
        final movie = snapshot.data?.results[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(movie: movie!),
              ),
            );
          },
          child: Column(
            children: [
              Image.network(
                'https://image.tmdb.org/t/p/original/${movie?.posterPath}',
                fit: BoxFit.contain,
              ),
              SizedBox(height: 8),
              Text(
                movie?.title ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(movie?.voteAverage ?? 0).toInt() * 10}%',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.star, color: Colors.yellow),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Released: ${movie?.releaseDate ?? ''}',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        );
      },
    );
  }
}
