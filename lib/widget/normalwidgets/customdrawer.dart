import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/firebase_function/firebasedb.dart';
import 'package:movies_app/helper/sharedpref/sharedpref.dart';
import 'package:movies_app/pages/loginscreen.dart';

class Customdrawer extends StatefulWidget {
  const Customdrawer({super.key});

  @override
  State<Customdrawer> createState() => _CustomdrawerState();
}

class _CustomdrawerState extends State<Customdrawer> {
  bool isdark = true;
  void loadtheme() async {
    final value = await Sharedpref.getbool('drawertheme');

    setState(() {
      isdark = value;
    });
  }

  @override
  void initState() {
    loadtheme();

    super.initState();
  }

  void toggletheme(bool value) {
    setState(() {
      isdark = value;
    });
    Sharedpref.setbool('drawertheme', isdark);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: isdark ? Colors.black : Colors.white,
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
            child: Center(),
          ),
          ListTile(
            leading: Icon(
              Icons.dark_mode,
              size: 15,
              color: isdark ? Colors.white : Colors.black,
            ),
            title: Text(
              'dark mode',
              style: TextStyle(color: isdark ? Colors.white : Colors.black),
            ),
            onTap: () => Navigator.pop(context),
            trailing: Switch(
              value: isdark,
              onChanged: toggletheme,
              activeThumbColor: Colors.red,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
              size: 15,
              color: isdark ? Colors.white : Colors.black,
            ),
            title: Text(
              'logout',
              style: TextStyle(color: isdark ? Colors.white : Colors.black),
            ),
            onTap: () {
              Firebasedb().signout();
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => Loginscreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 15,
              color: isdark ? Colors.white : Colors.black,
            ),
            title: Text(
              'clear sharedpref',
              style: TextStyle(color: isdark ? Colors.white : Colors.black),
            ),
            onTap: () {
              Sharedpref.clearall();
              Navigator.pop(context);
              Fluttertoast.showToast(
                msg: 'sharedpref got cleared ..',
                backgroundColor: Colors.white,
                textColor: Colors.red,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            },
          ),
        ],
      ),
    );
  }
}
