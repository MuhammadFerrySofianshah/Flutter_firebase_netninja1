import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_netninja/models/user_id.dart';
import 'package:flutter_firebase_netninja/screens/authenticate/sign_in_email_pass/sign_in_email.dart';
import 'package:flutter_firebase_netninja/screens/home/home.dart';
import 'package:flutter_firebase_netninja/services/database.dart';
import 'package:flutter_firebase_netninja/widget.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // CREATE USER OBJ BASED ON FIREBASEUSER
  UserID? _userFromFirebaseUser(User? user) {
    return user != null ? UserID(uid: user.uid) : null;
  }

  // AUTH CHANGE USER 'STREAM'
  Stream<UserID?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebaseUser);
  }

  // SIGN IN ANONYMOUS
  Future signInAnon() async {
    try {
      UserCredential result = await _firebaseAuth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print("Firebase Authentication Error: ${e.message}");
      return null;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // SIGN IN WITH EMAIL PASSWORD
  Future<UserID?> signInWithEmailPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if (user != null) {
        print('berhasil masuk');
        wPushReplacement(context, Home());
      }
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        wShowDialog(context, 'No user found for that email.', redColor);
      } else if (e.code == 'wrong-password') {
        wShowDialog(
            context, 'Wrong password provided for that user.', redColor);
      }
      return null;
    }
  }

  // REGISTER WITH EMAIL PASSWORD
  Future<UserID?> registerWithEmailPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      wPushReplacement(context, SignInEmail());
      User? user = result.user;
      // create a new document for user with uid
      await DatabaseServices(uid: user!.uid)
          .updateUserData('0', 'New Member', 100);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        wShowDialog(context, 'The password provided is too weak.', redColor);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        wShowDialog(
            context, 'The account already exists for that email.', redColor);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  // SIGN OUT
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
