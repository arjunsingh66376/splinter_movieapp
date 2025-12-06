import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      Fluttertoast.showToast(
        msg: 'movie removed from favorites',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      await db.addFavorite(
        movieId: movieId,
        title: title,
        posterPath: posterPath,
      );
      Fluttertoast.showToast(
        msg: 'movie added to  favorites',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  bool isFavorite(String movieId) {
    return favorites.any((f) => f["id"] == movieId);
  }
}
