import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/provider/FavoritesProvider%20.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final String movieId;
  final String title;
  final String posterPath;

  const FavoriteButton({
    super.key,
    required this.movieId,
    required this.title,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    final fav = context.watch<FavoriteProvider>();
    final isFavs = fav.isFavorite(movieId);

    return IconButton(
      icon: Icon(
        isFavs ? Icons.favorite : Icons.favorite_border,
        color: isFavs ? Colors.red : Colors.white,
      ),
      onPressed: () {
        fav.toggleFavorite(
          movieId: movieId,
          title: title,
          posterPath: posterPath,
        );
      },
    );
  }
}
