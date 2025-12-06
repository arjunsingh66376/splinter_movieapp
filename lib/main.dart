import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/firebase_function/firebasedb.dart';
import 'package:movies_app/pages/splashscreen.dart';
import 'package:movies_app/provider/FavoritesProvider%20.dart';
import 'package:movies_app/provider/authprovider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Authprovider()),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(Firebasedb()),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
      home: Splashscreen(),
    );
  }
}
