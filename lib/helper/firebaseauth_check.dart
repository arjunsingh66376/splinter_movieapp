import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/pages/homepage.dart';
import 'package:movies_app/pages/loginscreen.dart';

class FirebaseauthCheck extends StatefulWidget {
  const FirebaseauthCheck({super.key});

  @override
  State<FirebaseauthCheck> createState() => _FirebaseauthCheckState();
}

class _FirebaseauthCheckState extends State<FirebaseauthCheck> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const Homepage();
        } else {
          return const Loginscreen();
        }
      },
    );
  }
}
