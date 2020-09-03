// To parse this JSON data, do
//
//     final searchQuery = searchQueryFromJson(jsonString);

import 'dart:convert';

class SearchQuery {
  int page;
  List<Result> results;
  int totalResults;
  int totalPages;

  SearchQuery({
    this.page,
    this.results,
    this.totalResults,
    this.totalPages,
  });

  factory SearchQuery.fromRawJson(String str) => SearchQuery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchQuery.fromJson(Map<String, dynamic> json) => SearchQuery(
    page: json["page"] == null ? null : json["page"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalResults: json["total_results"] == null ? null : json["total_results"],
    totalPages: json["total_pages"] == null ? null : json["total_pages"],
  );

  Map<String, dynamic> toJson() => {
    "page": page == null ? null : page,
    "results": results == null ? null : List<dynamic>.from(results.map((x) => x.toJson())),
    "total_results": totalResults == null ? null : totalResults,
    "total_pages": totalPages == null ? null : totalPages,
  };
}

class Result {
  String posterPath;
  double popularity;
  int id;
  String overview;
  String backdropPath;
  double voteAverage;
  MediaType mediaType;
  String firstAirDate;
  List<String> originCountry;
  List<int> genreIds;
  OriginalLanguage originalLanguage;
  int voteCount;
  String name;
  String originalName;
  bool adult;
  String releaseDate;
  String originalTitle;
  String title;
  bool video;
  String profilePath;
  List<Result> knownFor;

  Result({
    this.posterPath,
    this.popularity,
    this.id,
    this.overview,
    this.backdropPath,
    this.voteAverage,
    this.mediaType,
    this.firstAirDate,
    this.originCountry,
    this.genreIds,
    this.originalLanguage,
    this.voteCount,
    this.name,
    this.originalName,
    this.adult,
    this.releaseDate,
    this.originalTitle,
    this.title,
    this.video,
    this.profilePath,
    this.knownFor,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    posterPath: json["poster_path"] == null ? null : json["poster_path"],
    popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
    id: json["id"] == null ? null : json["id"],
    overview: json["overview"] == null ? null : json["overview"],
    backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
    voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
    mediaType: json["media_type"] == null ? null : mediaTypeValues.map[json["media_type"]],
    firstAirDate: json["first_air_date"] == null ? null : json["first_air_date"],
    originCountry: json["origin_country"] == null ? null : List<String>.from(json["origin_country"].map((x) => x)),
    genreIds: json["genre_ids"] == null ? null : List<int>.from(json["genre_ids"].map((x) => x)),
    originalLanguage: json["original_language"] == null ? null : originalLanguageValues.map[json["original_language"]],
    voteCount: json["vote_count"] == null ? null : json["vote_count"],
    name: json["name"] == null ? null : json["name"],
    originalName: json["original_name"] == null ? null : json["original_name"],
    adult: json["adult"] == null ? null : json["adult"],
    releaseDate: json["release_date"] == null ? null : json["release_date"],
    originalTitle: json["original_title"] == null ? null : json["original_title"],
    title: json["title"] == null ? null : json["title"],
    video: json["video"] == null ? null : json["video"],
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
    knownFor: json["known_for"] == null ? null : List<Result>.from(json["known_for"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "poster_path": posterPath == null ? null : posterPath,
    "popularity": popularity == null ? null : popularity,
    "id": id == null ? null : id,
    "overview": overview == null ? null : overview,
    "backdrop_path": backdropPath == null ? null : backdropPath,
    "vote_average": voteAverage == null ? null : voteAverage,
    "media_type": mediaType == null ? null : mediaTypeValues.reverse[mediaType],
    "first_air_date": firstAirDate == null ? null : firstAirDate,
    "origin_country": originCountry == null ? null : List<dynamic>.from(originCountry.map((x) => x)),
    "genre_ids": genreIds == null ? null : List<dynamic>.from(genreIds.map((x) => x)),
    "original_language": originalLanguage == null ? null : originalLanguageValues.reverse[originalLanguage],
    "vote_count": voteCount == null ? null : voteCount,
    "name": name == null ? null : name,
    "original_name": originalName == null ? null : originalName,
    "adult": adult == null ? null : adult,
    "release_date": releaseDate == null ? null : releaseDate,
    "original_title": originalTitle == null ? null : originalTitle,
    "title": title == null ? null : title,
    "video": video == null ? null : video,
    "profile_path": profilePath == null ? null : profilePath,
    "known_for": knownFor == null ? null : List<dynamic>.from(knownFor.map((x) => x.toJson())),
  };
}

enum MediaType { TV, MOVIE, PERSON }

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE,
  "person": MediaType.PERSON,
  "tv": MediaType.TV
});

enum OriginalLanguage { EN, IT }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "it": OriginalLanguage.IT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
