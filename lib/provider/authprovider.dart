import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class Authprovider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? _user;
  User? get getuser => _user;

  Authprovider() {
    auth.authStateChanges().listen((u) {
      _user = u;
      notifyListeners();
    });
  }
}
