import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:to_do_app/splash&FirebaseServices/splashServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Splashservices().isLogin(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.amber, Colors.black]),
        ),
        child: Column(
          children: [
            SizedBox(height: .25.sh),
            FaIcon(
              FontAwesomeIcons.clipboardList,
              color: Colors.white,
              size: .14.sh,
            ),
            SizedBox(
              height: .1.sh,
            ),
            Text(
              'Yet TO DO',
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
            SizedBox(height: .07.sh),
            Text(
              'Welcome Back',
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: .03.sh),
            SizedBox(
              height: .1.sh,
            ),
            SizedBox(
              height: 0.001.sh,
            )
          ],
        ),
      ),
    );
  }
}
