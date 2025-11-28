import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/api/api_service/allapilink/allapilink.dart';
import 'package:movies_app/model/movie.dart';

class TmdbService {
  final popularurl = Allapilink.popularurl();
  final topratedurl = Allapilink.toprated();
  final upcomingurl = Allapilink.upcoming();
  final airingtodayurl = Allapilink.airingtoday();
  final nowplayingurl = Allapilink.nowplaying();

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

  Future<List<Movie>> getnowplaying() async {
    try {
      final response = await http.get(Uri.parse(nowplayingurl));
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

  Future<List<Movie>> gettoprated() async {
    try {
      final response = await http.get(Uri.parse(topratedurl));
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

  Future<List<Movie>> getupcoming() async {
    try {
      final response = await http.get(Uri.parse(upcomingurl));
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

  Future<List<Movie>> getairingtoday() async {
    try {
      final response = await http.get(Uri.parse(airingtodayurl));
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
