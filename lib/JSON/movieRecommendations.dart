// To parse this JSON data, do
//
//     final movieRecommendations = movieRecommendationsFromJson(jsonString);

import 'dart:convert';

class MovieRecommendations {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  MovieRecommendations({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieRecommendations.fromRawJson(String str) => MovieRecommendations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieRecommendations.fromJson(Map<String, dynamic> json) => MovieRecommendations(
    page: json["page"] == null ? null : json["page"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"] == null ? null : json["total_pages"],
    totalResults: json["total_results"] == null ? null : json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page == null ? null : page,
    "results": results == null ? null : List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages == null ? null : totalPages,
    "total_results": totalResults == null ? null : totalResults,
  };
}

class Result {
  bool adult;
  dynamic backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  DateTime releaseDate;
  dynamic posterPath;
  double popularity;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.releaseDate,
    this.posterPath,
    this.popularity,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"] == null ? null : json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: json["genre_ids"] == null ? null : List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"] == null ? null : json["id"],
    originalLanguage: json["original_language"] == null ? null : json["original_language"],
    originalTitle: json["original_title"] == null ? null : json["original_title"],
    overview: json["overview"] == null ? null : json["overview"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    posterPath: json["poster_path"],
    popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
    title: json["title"] == null ? null : json["title"],
    video: json["video"] == null ? null : json["video"],
    voteAverage: json["vote_average"] == null ? null : json["vote_average"],
    voteCount: json["vote_count"] == null ? null : json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult == null ? null : adult,
    "backdrop_path": backdropPath,
    "genre_ids": genreIds == null ? null : List<dynamic>.from(genreIds.map((x) => x)),
    "id": id == null ? null : id,
    "original_language": originalLanguage == null ? null : originalLanguage,
    "original_title": originalTitle == null ? null : originalTitle,
    "overview": overview == null ? null : overview,
    "release_date": releaseDate == null ? null : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "poster_path": posterPath,
    "popularity": popularity == null ? null : popularity,
    "title": title == null ? null : title,
    "video": video == null ? null : video,
    "vote_average": voteAverage == null ? null : voteAverage,
    "vote_count": voteCount == null ? null : voteCount,
  };
}
