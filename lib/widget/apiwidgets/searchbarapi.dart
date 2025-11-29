import 'package:flutter/material.dart';
import 'package:movies_app/api/api_service/tmdb_service.dart';
import 'package:movies_app/constant/url.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/utils/context_extension.dart';

class Searchbarapi extends StatefulWidget {
  final String query;
  const Searchbarapi({super.key, required this.query});

  @override
  State<Searchbarapi> createState() => _SearchbarapiState();
}

class _SearchbarapiState extends State<Searchbarapi> {
  late Future<List<Movie>> _searchmovie;
  TmdbService tmdbservice = TmdbService();
  final String imgurl = Url.baseImgUrl;

  @override
  void initState() {
    _searchmovie = tmdbservice.getsearchmovies(widget.query);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenh = context.h;
    final screenw = context.w;
    return FutureBuilder<List<Movie>>(
      future: _searchmovie,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: const CircularProgressIndicator(color: Colors.red),
          );
        } else if (snapshot.hasError) {
          return Text('error : ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final moviedata = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 200),
            child: SizedBox(
              height: screenh,
              child: GridView.builder(
                itemCount: moviedata.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 15,
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2.6,
                ),
                itemBuilder: (context, index) {
                  final m = moviedata[index];
                  return Container(
                    // color: Colors.amber,
                    // height: 60,
                    // width: 120,
                    child: Column(
                      children: [
                        // image container
                        Container(
                          height: screenh * 0.23,
                          width: screenw * 2,

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: m.posterpath == null
                                ? Container(
                                    color: Colors.grey.shade800,
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.red,
                                    ),
                                  )
                                : Image.network(
                                    '$imgurl${m.posterpath}',
                                    fit: BoxFit.fill,

                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey.shade700,
                                        child: Icon(
                                          Icons.broken_image,
                                          color: Colors.red,
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: Text(
                            m.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
        return const Text('no movies found ');
      },
    );
  }
}
