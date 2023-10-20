import 'package:flutter/material.dart';
import 'package:sgpaypoint/presentation/routes.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import '../../utils/mode.dart';
import '../screens/buy_giftcard/index.dart';

class BuyGiftCard extends StatelessWidget {
  const BuyGiftCard({super.key});

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    bool darkMode = isDarkMode(context);
    AllTheme sgtheme = AllTheme();

    return Scaffold(
      backgroundColor: Color.fromARGB(237, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "Buy Giftcard",
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
                      // Navigator.pushNamed(context, AppRoutes.buy_giftcard_amex);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyGiftCardScreen(
                                    giftcard_name: "AMEX",
                                    image_url:
                                        'public/images/america_express_logo-removebg-preview.png',
                                  )));
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
                      // Navigator.pushNamed(
                      //     context, AppRoutes.buy_giftcard_google_play);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyGiftCardScreen(
                                    giftcard_name: "Google Play",
                                    image_url:
                                        'public/images/google_play_logo-removebg-preview.png',
                                  )));
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
                      // Navigator.pushNamed(context, AppRoutes.buy_giftcard_macy);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyGiftCardScreen(
                                    giftcard_name: "Macy",
                                    image_url:
                                        'public/images/Macys-logo-removebg-preview.png',
                                  )));
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
                        // Navigator.pushNamed(
                        //     context, AppRoutes.buy_giftcard_nordstorm);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BuyGiftCardScreen(
                                      giftcard_name: "Nordstorm",
                                      image_url:
                                          'public/images/nordstorm_logo-removebg-preview.png',
                                    )));
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
                      // Navigator.pushNamed(
                      //     context, AppRoutes.buy_giftcard_walmart);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyGiftCardScreen(
                                    giftcard_name: "Walmart",
                                    image_url:
                                        'public/images/walmart_logo-removebg-preview.png',
                                  )));
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
                      // Navigator.pushNamed(
                      //     context, AppRoutes.buy_giftcard_steam);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyGiftCardScreen(
                                    giftcard_name: "Steam",
                                    image_url: 'public/images/steam_logo.png',
                                  )));
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
                      // Navigator.pushNamed(
                      //     context, AppRoutes.buy_giftcard_razer);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyGiftCardScreen(
                                    giftcard_name: "Razer",
                                    image_url: 'public/images/razor_logo.png',
                                  )));
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
                      // Navigator.pushNamed(
                      //     context, AppRoutes.buy_giftcard_amazon);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyGiftCardScreen(
                                    giftcard_name: "Amazon",
                                    image_url:
                                        'public/images/amazon-removebg-preview.png',
                                  )));
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
                      // Navigator.pushNamed(
                      //     context, AppRoutes.buy_giftcard_itunes);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyGiftCardScreen(
                                    giftcard_name: "Itunes",
                                    image_url:
                                        'public/images/itunes-removebg-preview.png',
                                  )));
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
                      // Navigator.pushNamed(context, AppRoutes.buy_giftcard_ebay);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyGiftCardScreen(
                                    giftcard_name: "Ebay",
                                    image_url:
                                        'public/images/ebay-removebg-preview.png',
                                  )));
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
