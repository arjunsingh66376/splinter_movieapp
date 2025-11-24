import 'package:flutter/material.dart';
import 'package:movies_app/pages/homepage.dart';
import 'package:movies_app/pages/loginscreen.dart';
import 'package:movies_app/pages/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Loginscreen(),
    );
  }
}
