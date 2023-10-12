import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sgpaypoint/presentation/routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sgpaypoint/data/state/user.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  cacheUserDetails() async {
    final storage = FlutterSecureStorage();

    String? signed = await storage.read(key: 'sign');
    String? data = await storage.read(key: 'user_data');
    String? expiryDateString = await storage.read(key: 'expiryDate');

    if (signed != null) {
      if (data != null && expiryDateString != null) {
        DateTime expiryDate = DateTime.parse(expiryDateString);
        if (DateTime.now().isAfter(expiryDate)) {
          // Data has expired, delete it
          await storage.delete(key: 'user_data');
          await storage.delete(key: 'expiryDate');
          Navigator.pushNamed(context, AppRoutes.signin);
        } else {
          Provider.of<UserState>(context, listen: false)
              .updateUserDetails(jsonDecode(data!));
          Navigator.pushNamed(context, AppRoutes.main);
        }
      } else {
        Navigator.pushNamed(context, AppRoutes.signin);
      }
    } else {
      startTimer();
    }
  }

  startTimer() {
    Timer(Duration(seconds: 3), () async {
      Navigator.pushNamed(context, AppRoutes.onboarding);
    });
  }

  @override
  void initState() {
    super.initState();
    cacheUserDetails();
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
