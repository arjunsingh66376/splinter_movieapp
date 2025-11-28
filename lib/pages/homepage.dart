import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/widget/apiwidgets/nowplaying.dart';
import 'package:movies_app/widget/customdrawer.dart';

import 'package:movies_app/widget/movies_carousel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
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
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoviesCarousel(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Now Playing',
                  style: GoogleFonts.pixelifySans(
                    fontSize: 30,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),

              Nowplaying(),
            ],
          ),
        ),
      ),
    );
  }
}
