import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sgpaypoint/presentation/routes.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTimer() {
    Timer(Duration(seconds: 3), () async {
      Navigator.pushNamed(context, AppRoutes.onboarding);
      // Navigator.pushNamed(context, AppRoutes.main);
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Image.asset(
            'public/images/sg_platform.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
