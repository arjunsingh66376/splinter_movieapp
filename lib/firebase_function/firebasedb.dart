import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebasedb {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future saveuserinfo(Map<String, dynamic> userinfo, String uid) async {
    try {
      return await _firestore.collection('users').doc(uid).set(userinfo);
    } catch (e) {
      // print('Firestore write error: $e');
      rethrow;
    }
  }

  Stream<DocumentSnapshot> getuserinfo(String uid) {
    try {
      return _firestore.collection('users').doc(uid).snapshots();
    } catch (e) {
      // print('Firestore error  while gettin user info: $e');
      rethrow;
    }
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // print('error  while  signin  : $e');
      rethrow;
    }
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // print('error while signing up : $e');
      rethrow;
    }
  }
}
