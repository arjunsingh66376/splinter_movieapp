import 'package:flutter/material.dart';
import 'package:movies_app/firebase_function/firebasedb.dart';

class FavoriteProvider with ChangeNotifier {
  final Firebasedb db;
  List<Map<String, dynamic>> favorites = [];

  FavoriteProvider(this.db) {
    _listenToFavorites();
  }

  void _listenToFavorites() {
    db.getFavorites().listen((favList) {
      favorites = favList;
      notifyListeners();
    });
  }

  Future<void> toggleFavorite({
    required String movieId,
    required String title,
    required String posterPath,
  }) async {
    final isFav = favorites.any((f) => f["id"] == movieId);

    if (isFav) {
      await db.removeFavorite(movieId);
    } else {
      await db.addFavorite(
        movieId: movieId,
        title: title,
        posterPath: posterPath,
      );
    }
  }

  bool isFavorite(String movieId) {
    return favorites.any((f) => f["id"] == movieId);
  }
}
