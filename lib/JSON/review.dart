// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

class Review {
  String id;
  String author;
  String content;
  String iso6391;
  int mediaId;
  String mediaTitle;
  String mediaType;
  String url;

  Review({
    this.id,
    this.author,
    this.content,
    this.iso6391,
    this.mediaId,
    this.mediaTitle,
    this.mediaType,
    this.url,
  });

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"] == null ? null : json["id"],
    author: json["author"] == null ? null : json["author"],
    content: json["content"] == null ? null : json["content"],
    iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
    mediaId: json["media_id"] == null ? null : json["media_id"],
    mediaTitle: json["media_title"] == null ? null : json["media_title"],
    mediaType: json["media_type"] == null ? null : json["media_type"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "author": author == null ? null : author,
    "content": content == null ? null : content,
    "iso_639_1": iso6391 == null ? null : iso6391,
    "media_id": mediaId == null ? null : mediaId,
    "media_title": mediaTitle == null ? null : mediaTitle,
    "media_type": mediaType == null ? null : mediaType,
    "url": url == null ? null : url,
  };
}
