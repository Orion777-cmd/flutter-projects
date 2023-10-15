class ItemModel {
  int? page;
  int? totalResults;
  int? totalPages;
  List<Result> results = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    page = parsedJson['page'];
    totalResults = parsedJson['total_results'];
    totalPages = parsedJson['total_pages'];
    if (parsedJson['results'] != null) {
      results = List<Result>.from(
        parsedJson['results'].map((result) => Result.fromJson(result)),
      );
    }
    
  }
}

class Result {
  int? voteCount;
  int? id;
  bool? video;
  double? voteAverage;
  String? title;
  double? popularity;
  String? posterPath;
  String? originalLanguage;
  String? originalTitle;
  List<int>? genreIds = [];
  String? backdropPath;
  bool? adult;
  String? overview;
  String? releaseDate;

  Result.fromJson(Map<String, dynamic> parsedJson) {
    voteCount = parsedJson['vote_count'];
    id = parsedJson['id'];
    video = parsedJson['video'];
    voteAverage = parsedJson['vote_average']?.toDouble() ?? 0.0;
    title = parsedJson['title'];
    popularity = parsedJson['popularity'];
    posterPath = parsedJson['poster_path'];
    originalLanguage = parsedJson['original_language'];
    originalTitle = parsedJson['original_title'];
    if (parsedJson['genre_ids'] != null) {
      genreIds = List<int>.from(parsedJson['genre_ids']);
    }
    // genreIds = List<int>.from(parsedJson['genre_ids']);
    backdropPath = parsedJson['backdrop_path'];
    adult = parsedJson['adult'];
    overview = parsedJson['overview'];
    releaseDate = parsedJson['release_date'];
  }
}
