import 'package:flutter/material.dart';
import 'package:movies_app/api/api_service/tmdb_service.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/pages/favoritepage.dart';
import 'package:movies_app/widget/apiwidgets/airingtoday.dart';
import 'package:movies_app/widget/apiwidgets/nowplaying.dart';
import 'package:movies_app/widget/apiwidgets/toprated.dart';
import 'package:movies_app/widget/apiwidgets/upcoming.dart';
import 'package:movies_app/widget/normalwidgets/customdrawer.dart';

import 'package:movies_app/widget/normalwidgets/movies_carousel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<Movie>> upcoming;
  late Future<List<Movie>> nowplaying;
  late Future<List<Movie>> toprated;
  late Future<List<Movie>> airingtoday;
  late Future<List<Movie>> tvrecommendation;
  late Future<List<Movie>> popularmovies;

  @override
  void initState() {
    upcoming = TmdbService().getupcoming();
    airingtoday = TmdbService().getairingtoday();
    toprated = TmdbService().gettoprated();
    tvrecommendation = TmdbService().gettvrecommendation();
    nowplaying = TmdbService().getnowplaying();
    popularmovies = TmdbService().getpopularmovies();

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldkey,
      drawer: Customdrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            _scaffoldkey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu, color: Colors.redAccent),
        ),

        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Row(
            children: [
              Text(
                'splinter',
                style: TextStyle(
                  fontFamily: 'pdark',
                  fontSize: 35,
                  color: Colors.red,
                ),
              ),
              Image.asset(
                'images/titleimage.png',
                fit: BoxFit.cover,
                width: 70,
                height: 60,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Favoritepage()),
            ),
            icon: Icon(
              Icons.favorite_outline_outlined,
              color: Colors.red,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoviesCarousel(future: popularmovies),

              SizedBox(height: 30),
              Text(
                'Now Playing',

                style: TextStyle(
                  fontFamily: 'pdark',
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              Nowplaying(future: nowplaying),

              Text(
                'Upcoming',
                style: TextStyle(
                  fontFamily: 'pdark',
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Upcoming(future: upcoming),
              SizedBox(height: 10),
              Text(
                'top rated',
                style: TextStyle(
                  fontFamily: 'pdark',
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Toprated(future: toprated),
              SizedBox(height: 10),
              Text(
                'airing today',
                style: TextStyle(
                  fontFamily: 'pdark',
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Airingtoday(future: airingtoday),
            ],
          ),
        ),
      ),
    );
  }
}
