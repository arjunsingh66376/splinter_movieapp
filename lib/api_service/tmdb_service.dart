import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/api/allapilink.dart';
import 'package:movies_app/model/movie.dart';

class TmdbService {
  final popularurl = Allapilink.popularurl();
  final topratedurl = Allapilink.toprated();
  final upcomingurl = Allapilink.upcoming();
  final airingtodayurl = Allapilink.airingtoday();

  Future<List<Movie>> getpopularmovies() async {
    try {
      final response = await http.get(Uri.parse(popularurl));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final List data = result['results'];
        return data.map((movie) => Movie.fromMap((movie))).toList();
      } else {
        print('error  ${response.statusCode}');
        throw Exception('failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      print(' error  : $e');

      rethrow;
    }
  }
}
