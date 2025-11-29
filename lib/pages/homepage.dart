import 'package:flutter/material.dart';
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
  @override
  void initState() {
    Airingtoday();
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
        // centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoviesCarousel(),

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

              Nowplaying(),

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
              Upcoming(),
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
              Toprated(),
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
              Airingtoday(),
            ],
          ),
        ),
      ),
    );
  }
}
