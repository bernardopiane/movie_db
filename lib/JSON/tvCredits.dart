// To parse this JSON data, do
//
//     final tvCredits = tvCreditsFromJson(jsonString);

import 'dart:convert';

class TvCredits {
  List<Cast> cast;
  List<Crew> crew;
  int id;

  TvCredits({
    this.cast,
    this.crew,
    this.id,
  });

  factory TvCredits.fromRawJson(String str) => TvCredits.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvCredits.fromJson(Map<String, dynamic> json) => TvCredits(
    cast: json["cast"] == null ? null : List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
    crew: json["crew"] == null ? null : List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "cast": cast == null ? null : List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": crew == null ? null : List<dynamic>.from(crew.map((x) => x.toJson())),
    "id": id == null ? null : id,
  };
}

class Cast {
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Cast({
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  factory Cast.fromRawJson(String str) => Cast.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    character: json["character"] == null ? null : json["character"],
    creditId: json["credit_id"] == null ? null : json["credit_id"],
    gender: json["gender"] == null ? null : json["gender"],
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    order: json["order"] == null ? null : json["order"],
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "character": character == null ? null : character,
    "credit_id": creditId == null ? null : creditId,
    "gender": gender == null ? null : gender,
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "order": order == null ? null : order,
    "profile_path": profilePath == null ? null : profilePath,
  };
}

class Crew {
  String creditId;
  String department;
  int gender;
  int id;
  String job;
  String name;
  String profilePath;

  Crew({
    this.creditId,
    this.department,
    this.gender,
    this.id,
    this.job,
    this.name,
    this.profilePath,
  });

  factory Crew.fromRawJson(String str) => Crew.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
    creditId: json["credit_id"] == null ? null : json["credit_id"],
    department: json["department"] == null ? null : json["department"],
    gender: json["gender"] == null ? null : json["gender"],
    id: json["id"] == null ? null : json["id"],
    job: json["job"] == null ? null : json["job"],
    name: json["name"] == null ? null : json["name"],
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "credit_id": creditId == null ? null : creditId,
    "department": department == null ? null : department,
    "gender": gender == null ? null : gender,
    "id": id == null ? null : id,
    "job": job == null ? null : job,
    "name": name == null ? null : name,
    "profile_path": profilePath == null ? null : profilePath,
  };
}
