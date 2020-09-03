// To parse this JSON data, do
//
//     final tvReview = tvReviewFromJson(jsonString);

import 'dart:convert';

class TvReview {
  int id;
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  TvReview({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TvReview.fromRawJson(String str) => TvReview.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvReview.fromJson(Map<String, dynamic> json) => TvReview(
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
  String author;
  String content;
  String id;
  String url;

  Result({
    this.author,
    this.content,
    this.id,
    this.url,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    author: json["author"] == null ? null : json["author"],
    content: json["content"] == null ? null : json["content"],
    id: json["id"] == null ? null : json["id"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "author": author == null ? null : author,
    "content": content == null ? null : content,
    "id": id == null ? null : id,
    "url": url == null ? null : url,
  };
}
