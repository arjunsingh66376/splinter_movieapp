import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/api_service/tmdb_service.dart';
import 'package:movies_app/constant/url.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/utls/context_extension.dart';

class Nowplaying extends StatefulWidget {
  const Nowplaying({super.key});

  @override
  State<Nowplaying> createState() => _NowplayingState();
}

class _NowplayingState extends State<Nowplaying> {
  final TmdbService tmdbService = TmdbService();
  late Future<List<Movie>> _nowplaying;
  final String baseimgurl = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    _nowplaying = TmdbService().getnowplaying();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenh = context.h;

    return FutureBuilder<List<Movie>>(
      future: _nowplaying,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: const CircularProgressIndicator(color: Colors.red),
          );
        } else if (snapshot.hasError) {
          return Text('error : ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final moviedata = snapshot.data!;

          return SizedBox(
            height: screenh * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: moviedata.length,
              itemBuilder: (context, index) {
                final m = moviedata[index];
                return Card(
                  color: Colors.black,
                  elevation: 5,
                  child: Image.network(
                    '$baseimgurl${m.posterpath}',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          );
        }
        return const Text('no movies found ');
      },
    );
  }
}
