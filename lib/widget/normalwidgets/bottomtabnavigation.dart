import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/pages/homepage.dart';
import 'package:movies_app/pages/profilepage.dart';
import 'package:movies_app/pages/searchpage.dart';

class Bottomtabnavigationpage extends StatefulWidget {
  const Bottomtabnavigationpage({super.key});

  @override
  State<Bottomtabnavigationpage> createState() =>
      _BottomtabnavigationpageState();
}

class _BottomtabnavigationpageState extends State<Bottomtabnavigationpage> {
  // List pages = ['Homepage', 'searchpage', 'profilepage'];

  List<Widget> allwidgetpages = [Homepage(), Searchpage(), Profilepage()];

  int intialindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.white,
        //  change  the background color  according to  themee like  when   theme is  white then  put the  bg   color    white
        backgroundColor: Colors.red,
        color: Colors.black,
        items: <Widget>[
          Icon(Icons.home_outlined, size: 30, color: Colors.red),
          Icon(Icons.search, size: 30, color: Colors.red),
          Icon(
            Icons.perm_device_information_outlined,
            size: 30,
            color: Colors.red,
          ),
        ],
        onTap: (index) {
          setState(() {
            intialindex = index;
          });
        },
      ),
      body: IndexedStack(index: intialindex, children: allwidgetpages),
    );
  }
}
