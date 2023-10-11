import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../../theme/main_theme.dart';
import '../../routes.dart';

class onBoardingScreen4 extends StatelessWidget {
  onBoardingScreen4({super.key});
  final AllTheme sgtheme = AllTheme();

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              left: -80,
              child: Image.asset(
                "public/images/ellipse-40.png",
                // width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.7,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: -120,
              top: 0,
              child: Image.asset(
                "public/images/ellipse-37.png",
                // width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.67,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Image.asset(
                "public/images/ellipse-39.png",
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
            Positioned(
                bottom: 50,
                left: 50,
                right: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.signin);
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: sgtheme.blackColor,
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.signup);
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(color: sgtheme.blackColor),
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )),
            Positioned(
              top: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 6),
                    child: Image.asset(
                      "public/images/sg_platform.png",
                      width: screen_width * 0.4,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                      child: Text(
                    "Welcome Back",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screen_width * 0.04),
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
            )
          ],
        ));
  }
}
