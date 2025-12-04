import 'package:flutter/material.dart';
import 'package:movies_app/pages/loginscreen.dart';
import 'package:movies_app/pages/bottomtabnavigationpage.dart';
import 'package:movies_app/provider/authprovider.dart';
import 'package:provider/provider.dart';

class FirebaseauthCheck extends StatelessWidget {
  const FirebaseauthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final provideruser = context.watch<Authprovider>();

    if (provideruser.getuser == null) {
      return const Loginscreen();
    } else {
      return Bottomtabnavigationpage();
    }
  }
}
