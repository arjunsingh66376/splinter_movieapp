import 'package:flutter/material.dart';
import 'package:movies_app/api/api_service/tmdb_service.dart';
import 'package:movies_app/constant/url.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/utils/context_extension.dart';

class Nowplaying extends StatefulWidget {
  const Nowplaying({super.key});

  @override
  State<Nowplaying> createState() => _NowplayingState();
}

class _NowplayingState extends State<Nowplaying> {
  final TmdbService tmdbService = TmdbService();
  late Future<List<Movie>> _nowplaying;
  final String imgurl = Url.baseImgUrl;

  @override
  void initState() {
    _nowplaying = TmdbService().getnowplaying();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenh = context.h;
    final screenw = context.w;

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
            height: screenh * 0.22,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: moviedata.length,
              itemBuilder: (context, index) {
                final m = moviedata[index];
                return Container(
                  width: screenw * 0.3,
                  // color: Colors.amber,
                  padding: EdgeInsets.only(left: 10, right: 10),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenh * 0.16,
                        width: screenw * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            '$imgurl${m.posterpath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        m.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
