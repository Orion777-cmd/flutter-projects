import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocks/top_rated_block.dart';
import 'movieDetailPage.dart';

class TopRated extends StatelessWidget {
  const TopRated({super.key});

  @override
  Widget build(BuildContext context) {
    final topRatedBloc = TopRatedBloc();
    topRatedBloc.fetchTopRatedMovies();
    return Scaffold(  
      // appBar: AppBar(  
      //   title: Text('Top Rated Movies'),
      //   titleTextStyle: TextStyle(fontFamily: "Poppins"),
      // ),
      body: StreamBuilder(  
        stream: topRatedBloc.topRated,
        builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot){
          if(snapshot.hasData){
            return buildTop(context, snapshot);
          }else if (snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          return Center(child:CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildTop(BuildContext context,AsyncSnapshot<ItemModel> snapshot){
    return ListView.separated(
      
      itemCount: snapshot.data?.results.length?? 0,
      separatorBuilder: (BuildContext context, int index)=> const Divider(  
        thickness: 1,
        color: Colors.amber,
        height: 8.0,
      ),
      itemBuilder: (BuildContext context, int index){
        final topMovies = snapshot.data?.results[index];
        return GestureDetector(  
          onTap: (){
            Navigator.push(  
              context,
              MaterialPageRoute(  
                builder: (context) => MovieDetailPage(movie: topMovies!)
              )
            );
            
          },
          child: Column(  
            children: [
              Image.network(  
                'https://image.tmdb.org/t/p/original/${topMovies?.posterPath}',
                fit: BoxFit.contain,
              ),
              SizedBox(height: 8,),
              Text(  
                topMovies?.title ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0,),
              Row(  
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(  
                    '${(topMovies?.voteAverage?? 0).toInt() * 10}%',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    
                  ),
                  SizedBox(width: 4.0,),
                  const Icon(  
                    Icons.star,
                    color: Colors.yellow,
                  )
                ]
              ),
               const SizedBox(height: 4),
              Text(
                'Released: ${topMovies?.releaseDate ?? ''}',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        );

      },
      );
  }
}