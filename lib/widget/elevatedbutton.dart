import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/constant/styles.dart';

class Custombutton extends StatelessWidget {
  final VoidCallback action;
  final Color color;
  final String name;
  final Color textcolor;

  const Custombutton({
    super.key,
    required this.action,
    required this.color,
    required this.name,
    required this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(100, 30),
        maximumSize: Size(180, 50),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(color: textcolor, fontFamily: 'pdark', fontSize: 19),
        ),
      ),
    );
  }
}
