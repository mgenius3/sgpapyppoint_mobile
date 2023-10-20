import 'package:flutter/material.dart';
import 'package:sgpaypoint/presentation/pages/splash.dart';
import 'package:sgpaypoint/presentation/pages/onboarding.dart';
import 'package:sgpaypoint/presentation/screens/onboarding/screen2.dart';
import 'package:sgpaypoint/presentation/screens/onboarding/screen3.dart';
import 'package:sgpaypoint/presentation/screens/onboarding/screen4.dart';
import 'package:sgpaypoint/presentation/pages/auth/sign_up.dart';
import 'package:sgpaypoint/presentation/pages/auth/sign_in.dart';
import 'package:sgpaypoint/presentation/pages/main.dart';
import 'package:sgpaypoint/presentation/pages/sell_giftcard.dart';
import 'package:sgpaypoint/presentation/pages/buy_giftcard.dart';

//sell giftcard
import 'package:sgpaypoint/presentation/screens/sell_giftcard/index.dart';
import 'package:sgpaypoint/presentation/screens/sell_giftcard/google_play.dart';
import 'package:sgpaypoint/presentation/screens/sell_giftcard/macy.dart';
import 'package:sgpaypoint/presentation/screens/sell_giftcard/nordstorm.dart';
import 'package:sgpaypoint/presentation/screens/sell_giftcard/walmart.dart';
import 'package:sgpaypoint/presentation/screens/sell_giftcard/steam.dart';
import 'package:sgpaypoint/presentation/screens/sell_giftcard/gold.dart';
import 'package:sgpaypoint/presentation/screens/sell_giftcard/amazon.dart';
import 'package:sgpaypoint/presentation/screens/sell_giftcard/itunes.dart';
import 'package:sgpaypoint/presentation/screens/sell_giftcard/ebay.dart';

//buy giftcard
import 'package:sgpaypoint/presentation/screens/buy_giftcard/index.dart';

import 'package:sgpaypoint/presentation/pages/sell_crypto.dart';
import 'package:sgpaypoint/presentation/pages/buy_crypto.dart';
import 'package:sgpaypoint/presentation/pages/airtime.dart';
import 'package:sgpaypoint/presentation/pages/deposit.dart';
import 'package:sgpaypoint/presentation/pages/data.dart';
import 'package:sgpaypoint/presentation/pages/cable.dart';
import 'package:sgpaypoint/presentation/pages/chart.dart';
import 'package:sgpaypoint/presentation/pages/chat.dart';
import 'package:sgpaypoint/presentation/pages/withdraw.dart';

class AppRoutes {
  static const String splash = '/';
  static const String main = '/main';
  static const String onboarding = '/onboarding';
  static const String onboarding_screen2 = '/onboarding/screen2';
  static const String onboarding_screen3 = '/onboarding/screen3';
  static const String onboarding_screen4 = '/onboarding/screen4';
  static const String signup = '/signup';
  static const String signin = '/signin';
  static const String sell_giftcard = 'sell_giftcard';
  static const String buy_giftcard = 'buy_giftcard';
  static const String sell_giftcard_amex = 'sell_giftcard/amex';
  static const String sell_giftcard_google_play = 'sell_giftcard/gp';
  static const String sell_giftcard_macy = 'sell_giftcard/macy';
  static const String sell_giftcard_nordstorm = 'sell_giftcard/nordstorm';
  static const String sell_giftcard_walmart = 'sell_giftcard/walmart';
  static const String sell_giftcard_steam = 'sell_giftcard/steam';
  static const String sell_giftcard_razer = 'sell_giftcard/razer';
  static const String sell_giftcard_amazon = 'sell_giftcard/amazon';
  static const String sell_giftcard_itunes = 'sell_giftcard/itunes';
  static const String sell_giftcard_ebay = 'sell_giftcard/ebay';

  static const String sell_crypto = 'sell_crypto';
  static const String buy_crypto = 'buy_crypto';
  static const String airtime = 'airtime';
  static const String deposit = 'deposit';
  static const String data = 'data';
  static const String cable = 'cable';
  static const String chart = 'chart';
  static const String chat = 'chat';
  static const String withdraw = 'withdraw';

  static Route<dynamic> generateRoute(RouteSettings routes) {
    switch (routes.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => Splash());
      case main:
        return MaterialPageRoute(builder: (_) => MainPage());
      case onboarding:
        return MaterialPageRoute(builder: (_) => onBoarding());
      case onboarding_screen2:
        return MaterialPageRoute(builder: (_) => onBoardingScreen2());
      case onboarding_screen3:
        return MaterialPageRoute(builder: (_) => onBoardingScreen3());
      case onboarding_screen4:
        return MaterialPageRoute(builder: (_) => onBoardingScreen4());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUp());
      case signin:
        return MaterialPageRoute(builder: (_) => SignIn());
      case sell_giftcard:
        return MaterialPageRoute(builder: (_) => SellGiftCard());
      case buy_giftcard:
        return MaterialPageRoute(builder: (_) => BuyGiftCard());
      // case sell_giftcard_amex:
      //   return MaterialPageRoute(builder: (_) => AmexGiftCardScreen());
      case sell_giftcard_google_play:
        return MaterialPageRoute(builder: (_) => GooglePlayGiftCardScreen());
      case sell_giftcard_macy:
        return MaterialPageRoute(builder: (_) => MacyGiftCardScreen());
      case sell_giftcard_nordstorm:
        return MaterialPageRoute(builder: (_) => NordstormGiftCardScreen());
      case sell_giftcard_walmart:
        return MaterialPageRoute(builder: (_) => WalmartGiftCardScreen());
      case sell_giftcard_razer:
        return MaterialPageRoute(builder: (_) => RazerGoldGiftCardScreen());
      case sell_giftcard_steam:
        return MaterialPageRoute(builder: (_) => SteamGiftCardScreen());
      case sell_giftcard_amazon:
        return MaterialPageRoute(builder: (_) => AmazonGiftCardScreen());
      case sell_giftcard_itunes:
        return MaterialPageRoute(builder: (_) => ItunesGiftCardScreen());
      case sell_giftcard_ebay:
        return MaterialPageRoute(builder: (_) => EbayGiftCardScreen());

      case sell_crypto:
        return MaterialPageRoute(builder: (_) => SellCrpto());
      case buy_crypto:
        return MaterialPageRoute(builder: (_) => BuyCrypto());
      case airtime:
        return MaterialPageRoute(builder: (_) => AirtimePurchase());
      case deposit:
        return MaterialPageRoute(builder: (_) => Deposit());
      case data:
        return MaterialPageRoute(builder: (_) => DataPurchase());
      case cable:
        return MaterialPageRoute(builder: (_) => CablePurchase());
      case chat:
        return MaterialPageRoute(builder: (_) => ChatPage());
      case withdraw:
        return MaterialPageRoute(builder: (_) => WithdrawalPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Error: Route not found!'),
            ),
          ),
        );
    }
  }
}
