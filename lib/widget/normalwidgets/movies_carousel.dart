import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_app/api/api_service/tmdb_service.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/utils/context_extension.dart';

class MoviesCarousel extends StatefulWidget {
  const MoviesCarousel({super.key});

  @override
  State<MoviesCarousel> createState() => _MoviesCarouselState();
}

class _MoviesCarouselState extends State<MoviesCarousel> {
  final TmdbService tmdbService = TmdbService();
  late Future<List<Movie>> _popularmovies;
  static const String baseimgurl = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    _popularmovies = tmdbService.getpopularmovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenw = context.w;
    final double screenh = context.h;
    return FutureBuilder<List<Movie>>(
      future: _popularmovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: const CircularProgressIndicator(color: Colors.purpleAccent),
          );
        } else if (snapshot.hasError) {
          return Text('error : ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final moviedata = snapshot.data!;

          return CarouselSlider(
            options: CarouselOptions(height: screenh * 0.4, autoPlay: true),
            items: moviedata.map((i) {
              // print('${i.posterpath}');
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    child: Container(
                      width: screenw,
                      height: screenh * 0.4,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          '$baseimgurl${i.posterpath}',
                          fit: BoxFit.fill,
                          width: screenw,
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        }

        return const Text('no movies found');
      },
    );
  }
}
