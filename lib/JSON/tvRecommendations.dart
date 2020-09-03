// To parse this JSON data, do
//
//     final tvRecommendations = tvRecommendationsFromJson(jsonString);

import 'dart:convert';

class TvRecommendations {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  TvRecommendations({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TvRecommendations.fromRawJson(String str) => TvRecommendations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvRecommendations.fromJson(Map<String, dynamic> json) => TvRecommendations(
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
  String backdropPath;
//  DateTime firstAirDate;
  List<int> genreIds;
  int id;
  OriginalLanguage originalLanguage;
  String originalName;
  String overview;
  List<OriginCountry> originCountry;
  String posterPath;
  double popularity;
  String name;
  double voteAverage;
  int voteCount;

  Result({
    this.backdropPath,
//    this.firstAirDate,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.originCountry,
    this.posterPath,
    this.popularity,
    this.name,
    this.voteAverage,
    this.voteCount,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
//    firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
    genreIds: json["genre_ids"] == null ? null : List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"] == null ? null : json["id"],
    originalLanguage: json["original_language"] == null ? null : originalLanguageValues.map[json["original_language"]],
    originalName: json["original_name"] == null ? null : json["original_name"],
    overview: json["overview"] == null ? null : json["overview"],
    originCountry: json["origin_country"] == null ? null : List<OriginCountry>.from(json["origin_country"].map((x) => originCountryValues.map[x])),
    posterPath: json["poster_path"] == null ? null : json["poster_path"],
    popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
    name: json["name"] == null ? null : json["name"],
    voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
    voteCount: json["vote_count"] == null ? null : json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath == null ? null : backdropPath,
//    "first_air_date": firstAirDate == null ? null : "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
    "genre_ids": genreIds == null ? null : List<dynamic>.from(genreIds.map((x) => x)),
    "id": id == null ? null : id,
    "original_language": originalLanguage == null ? null : originalLanguageValues.reverse[originalLanguage],
    "original_name": originalName == null ? null : originalName,
    "overview": overview == null ? null : overview,
    "origin_country": originCountry == null ? null : List<dynamic>.from(originCountry.map((x) => originCountryValues.reverse[x])),
    "poster_path": posterPath == null ? null : posterPath,
    "popularity": popularity == null ? null : popularity,
    "name": name == null ? null : name,
    "vote_average": voteAverage == null ? null : voteAverage,
    "vote_count": voteCount == null ? null : voteCount,
  };
}

enum OriginCountry { US, GB }

final originCountryValues = EnumValues({
  "GB": OriginCountry.GB,
  "US": OriginCountry.US
});

enum OriginalLanguage { EN }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN
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
