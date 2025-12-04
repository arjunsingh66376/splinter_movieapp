import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Movie {
  String posterpath;
  String title;
  double voteaverage;
  String name;
  String overview;

  int id;
  String? trailerKey;
  Movie({
    required this.posterpath,
    required this.title,
    required this.voteaverage,
    required this.name,
    required this.overview,

    required this.id,
    required this.trailerKey,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'poster_path': posterpath,
      'title': title,
      'vote_average': voteaverage,
      'name': name,
      'overview': overview,

      'id': id,
      'trailerKey': trailerKey,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    String? trailer;

    final videos = map['videos']?['results'] ?? [];

    // Pick first playable YouTube trailer
    final playableTrailer = videos.firstWhere(
      (v) => v['site'] == 'YouTube' && v['type'] == 'Trailer',
      orElse: () => null,
    );

    if (playableTrailer != null) trailer = playableTrailer['key'];
    return Movie(
      posterpath: map['poster_path'] ?? "",
      title: map['title'] ?? "Untitled",
      voteaverage: (map['vote_average'] ?? 0).toDouble(),
      name: map['name'] ?? 'Untitled',
      overview: map['overview'] ?? 'No description available',

      id: map['id'] ?? 0,
      trailerKey: trailer,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);
}
