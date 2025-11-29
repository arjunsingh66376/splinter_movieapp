import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Movie {
  String posterpath;
  String title;
  double voteaverage;
  String name;
  Movie({
    required this.posterpath,
    required this.title,
    required this.voteaverage,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'poster_path': posterpath,
      'title': title,
      'vote_average': voteaverage,
      'name': name,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      posterpath: map['poster_path'] ?? "",
      title: map['title'] ?? "no title",
      voteaverage: (map['vote_average'] ?? 0).toDouble(),
      name: map['name'] ?? 'no name',
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);
}
