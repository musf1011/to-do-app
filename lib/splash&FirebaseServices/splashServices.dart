import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/auth/welcomeScreen.dart';
import 'package:to_do_app/mainScr/mainScreen.dart';

class Splashservices {
  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      FirebaseAuth authent = FirebaseAuth.instance;
      final user = authent.currentUser;
      print('yes');

      if (user == null) {
        print('no');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Welcome()));
      } else {
        print('both');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      }
    });
  }
}
