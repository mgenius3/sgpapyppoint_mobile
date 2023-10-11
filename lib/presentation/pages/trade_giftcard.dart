import 'package:flutter/material.dart';
import 'package:sgpaypoint/presentation/routes.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import '../../utils/mode.dart';

class TradeGiftCard extends StatelessWidget {
  const TradeGiftCard({super.key});

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    bool darkMode = isDarkMode(context);
    AllTheme sgtheme = AllTheme();

    return Scaffold(
      backgroundColor: Color.fromARGB(237, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "Trade Giftcard",
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons
              .arrow_back_ios), // Use Icons.arrow_back for the left-pointing arrow
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 40),
          child: SingleChildScrollView(
            child: Center(
              child: Wrap(
                spacing: 20,
                runSpacing: 0.8,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.trade_giftcard_amex);
                    },
                    child: Container(
                      width: screen_width * 0.4,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "public/images/america_express_logo-removebg-preview.png",
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.trade_giftcard_google_play);
                    },
                    child: Container(
                      width: screen_width * 0.4,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "public/images/google_play_logo-removebg-preview.png",
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.trade_giftcard_macy);
                    },
                    child: Container(
                      width: screen_width * 0.4,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "public/images/Macys-logo-removebg-preview.png",
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.trade_giftcard_nordstorm);
                      },
                      child: Container(
                        width: screen_width * 0.4,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Image.asset(
                            "public/images/nordstorm_logo-removebg-preview.png",
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.trade_giftcard_walmart);
                    },
                    child: Container(
                      width: screen_width * 0.4,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "public/images/walmart_logo-removebg-preview.png",
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.trade_giftcard_steam);
                    },
                    child: Container(
                      width: screen_width * 0.4,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "public/images/steam_logo.png",
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.trade_giftcard_razer);
                    },
                    child: Container(
                      width: screen_width * 0.4,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "public/images/razor_logo.png",
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.trade_giftcard_amazon);
                    },
                    child: Container(
                      width: screen_width * 0.4,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "public/images/amazon-removebg-preview.png",
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.trade_giftcard_itunes);
                    },
                    child: Container(
                      width: screen_width * 0.4,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "public/images/itunes-removebg-preview.png",
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.trade_giftcard_ebay);
                    },
                    child: Container(
                      width: screen_width * 0.4,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "public/images/ebay-removebg-preview.png",
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
