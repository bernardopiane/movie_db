// To parse this JSON data, do
//
//     final movieReview = movieReviewFromJson(jsonString);

import 'dart:convert';

class MovieReview {
  int id;
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  MovieReview({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieReview.fromRawJson(String str) => MovieReview.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieReview.fromJson(Map<String, dynamic> json) => MovieReview(
    id: json["id"] == null ? null : json["id"],
    page: json["page"] == null ? null : json["page"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"] == null ? null : json["total_pages"],
    totalResults: json["total_results"] == null ? null : json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "page": page == null ? null : page,
    "results": results == null ? null : List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages == null ? null : totalPages,
    "total_results": totalResults == null ? null : totalResults,
  };
}

class Result {
  String id;
  String author;
  String content;
  String url;

  Result({
    this.id,
    this.author,
    this.content,
    this.url,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    author: json["author"] == null ? null : json["author"],
    content: json["content"] == null ? null : json["content"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "author": author == null ? null : author,
    "content": content == null ? null : content,
    "url": url == null ? null : url,
  };
}
