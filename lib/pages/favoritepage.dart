import 'package:flutter/material.dart';
import 'package:movies_app/provider/FavoritesProvider%20.dart';
import 'package:provider/provider.dart';

class Favoritepage extends StatelessWidget {
  const Favoritepage({super.key});

  @override
  Widget build(BuildContext context) {
    final fav = context.watch<FavoriteProvider>();
    final favorites = fav.favorites;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.red),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "favorites movie",
          style: TextStyle(fontFamily: 'pdark', color: Colors.red),
        ),
      ),

      body: favorites.isEmpty
          ? const Center(
              child: Text(
                "No favorites yet",
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: favorites.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final movie = favorites[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          movie["posterPath"],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movie["title"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
