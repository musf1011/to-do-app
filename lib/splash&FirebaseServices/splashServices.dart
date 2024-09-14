import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/auth/signIn.dart';
import 'package:to_do_app/auth/signUp.dart';
import 'package:to_do_app/auth/welcomeScreen.dart';

class Splashservices {
  void isLogin(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      final user = 1; //auth.currentUser;
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUp()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Welcome()));
      }
    });
    // FirebaseAuth auth = FirebaseAuth.instance;
  }
}
