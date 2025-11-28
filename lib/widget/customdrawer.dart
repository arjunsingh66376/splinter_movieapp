import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customdrawer extends StatelessWidget {
  const Customdrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/drawerimage.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              // child: Text(
              //   'drawer',
              //   style: TextStyle(fontFamily: 'pdark', color: Colors.white),
              // ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings, size: 15, color: Colors.white),
            title: Text('Setting', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined, size: 15, color: Colors.white),
            title: Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
