// To parse this JSON data, do
//
//     final tvPopularResults = tvPopularResultsFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:movie_db/data.dart';

class TvPopularResults with ChangeNotifier {
  int page;
  List<Result> results;
  int totalResults;
  int totalPages;

  TvPopularResults({
    this.page,
    this.results,
    this.totalResults,
    this.totalPages,
  });

  factory TvPopularResults.fromRawJson(String str) => TvPopularResults.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvPopularResults.fromJson(Map<String, dynamic> json) => TvPopularResults(
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

  void changePage(int page){
    this.page = page;
    notifyListeners();
  }

  Future getMoreResults(page) async {

    if(this.results == null)
      this.results = new List<Result>();

    var newData = await getPopularTv(page);
    print(newData.results);
    newData.results.forEach((item){
      this.results.add(item);
    });
    notifyListeners();
  }

}

class Result {
  String posterPath;
  double popularity;
  int id;
  String backdropPath;
  double voteAverage;
  String overview;
  DateTime firstAirDate;
  List<OriginCountry> originCountry;
  List<int> genreIds;
  OriginalLanguage originalLanguage;
  int voteCount;
  String name;
  String originalName;

  Result({
    this.posterPath,
    this.popularity,
    this.id,
    this.backdropPath,
    this.voteAverage,
    this.overview,
    this.firstAirDate,
    this.originCountry,
    this.genreIds,
    this.originalLanguage,
    this.voteCount,
    this.name,
    this.originalName,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    posterPath: json["poster_path"] == null ? null : json["poster_path"],
    popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
    id: json["id"] == null ? null : json["id"],
    backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
    voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
    overview: json["overview"] == null ? null : json["overview"],
    firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
    originCountry: json["origin_country"] == null ? null : List<OriginCountry>.from(json["origin_country"].map((x) => originCountryValues.map[x])),
    genreIds: json["genre_ids"] == null ? null : List<int>.from(json["genre_ids"].map((x) => x)),
    originalLanguage: json["original_language"] == null ? null : originalLanguageValues.map[json["original_language"]],
    voteCount: json["vote_count"] == null ? null : json["vote_count"],
    name: json["name"] == null ? null : json["name"],
    originalName: json["original_name"] == null ? null : json["original_name"],
  );

  Map<String, dynamic> toJson() => {
    "poster_path": posterPath == null ? null : posterPath,
    "popularity": popularity == null ? null : popularity,
    "id": id == null ? null : id,
    "backdrop_path": backdropPath == null ? null : backdropPath,
    "vote_average": voteAverage == null ? null : voteAverage,
    "overview": overview == null ? null : overview,
    "first_air_date": firstAirDate == null ? null : "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
    "origin_country": originCountry == null ? null : List<dynamic>.from(originCountry.map((x) => originCountryValues.reverse[x])),
    "genre_ids": genreIds == null ? null : List<dynamic>.from(genreIds.map((x) => x)),
    "original_language": originalLanguage == null ? null : originalLanguageValues.reverse[originalLanguage],
    "vote_count": voteCount == null ? null : voteCount,
    "name": name == null ? null : name,
    "original_name": originalName == null ? null : originalName,
  };
}

enum OriginCountry { US, GB, JP }

final originCountryValues = EnumValues({
  "GB": OriginCountry.GB,
  "JP": OriginCountry.JP,
  "US": OriginCountry.US
});

enum OriginalLanguage { EN, JA }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "ja": OriginalLanguage.JA
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
