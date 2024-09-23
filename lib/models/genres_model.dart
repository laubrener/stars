import 'dart:convert';

class GenresList {
  final List<Genre>? genres;

  GenresList({
    this.genres,
  });

  factory GenresList.fromRawJson(String str) =>
      GenresList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GenresList.fromJson(Map<String, dynamic> json) => GenresList(
        genres: json["genres"] == null
            ? []
            : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": genres == null
            ? []
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
      };
}

class Genre {
  final int? id;
  final String? name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromRawJson(String str) => Genre.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
