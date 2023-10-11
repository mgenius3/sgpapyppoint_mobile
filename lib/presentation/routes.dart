import 'package:flutter/material.dart';
import 'package:sgpaypoint/presentation/pages/splash.dart';
import 'package:sgpaypoint/presentation/pages/onboarding.dart';
import 'package:sgpaypoint/presentation/screens/onboarding/screen2.dart';
import 'package:sgpaypoint/presentation/screens/onboarding/screen3.dart';
import 'package:sgpaypoint/presentation/screens/onboarding/screen4.dart';
import 'package:sgpaypoint/presentation/pages/auth/sign_up.dart';
import 'package:sgpaypoint/presentation/pages/auth/sign_in.dart';
import 'package:sgpaypoint/presentation/pages/main.dart';
import 'package:sgpaypoint/presentation/pages/trade_giftcard.dart';
import 'package:sgpaypoint/presentation/screens/trade_giftcard/amex.dart';
import 'package:sgpaypoint/presentation/screens/trade_giftcard/google_play.dart';
import 'package:sgpaypoint/presentation/screens/trade_giftcard/macy.dart';
import 'package:sgpaypoint/presentation/screens/trade_giftcard/nordstorm.dart';
import 'package:sgpaypoint/presentation/screens/trade_giftcard/walmart.dart';
import 'package:sgpaypoint/presentation/screens/trade_giftcard/steam.dart';
import 'package:sgpaypoint/presentation/screens/trade_giftcard/gold.dart';
import 'package:sgpaypoint/presentation/screens/trade_giftcard/amazon.dart';
import 'package:sgpaypoint/presentation/screens/trade_giftcard/itunes.dart';
import 'package:sgpaypoint/presentation/screens/trade_giftcard/ebay.dart';

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
  static const String trade_giftcard = 'trade_giftcard';
  static const String trade_giftcard_amex = 'trade_giftcard/amex';
  static const String trade_giftcard_google_play = 'trade_giftcard/gp';
  static const String trade_giftcard_macy = 'trade_giftcard/macy';
  static const String trade_giftcard_nordstorm = 'trade_giftcard/nordstorm';
  static const String trade_giftcard_walmart = 'trade_giftcard/walmart';
  static const String trade_giftcard_steam = 'trade_giftcard/steam';
  static const String trade_giftcard_razer = 'trade_giftcard/razer';
  static const String trade_giftcard_amazon = 'trade_giftcard/amazon';
  static const String trade_giftcard_itunes = 'trade_giftcard/itunes';
  static const String trade_giftcard_ebay = 'trade_giftcard/ebay';

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
      case trade_giftcard:
        return MaterialPageRoute(builder: (_) => TradeGiftCard());
      case trade_giftcard_amex:
        return MaterialPageRoute(builder: (_) => AmexGiftCardScreen());
      case trade_giftcard_google_play:
        return MaterialPageRoute(builder: (_) => GooglePlayGiftCardScreen());
      case trade_giftcard_macy:
        return MaterialPageRoute(builder: (_) => MacyGiftCardScreen());
      case trade_giftcard_nordstorm:
        return MaterialPageRoute(builder: (_) => NordstormGiftCardScreen());
      case trade_giftcard_walmart:
        return MaterialPageRoute(builder: (_) => WalmartGiftCardScreen());
      case trade_giftcard_razer:
        return MaterialPageRoute(builder: (_) => RazerGoldGiftCardScreen());
      case trade_giftcard_steam:
        return MaterialPageRoute(builder: (_) => SteamGiftCardScreen());
      case trade_giftcard_amazon:
        return MaterialPageRoute(builder: (_) => AmazonGiftCardScreen());
      case trade_giftcard_itunes:
        return MaterialPageRoute(builder: (_) => ItunesGiftCardScreen());
      case trade_giftcard_ebay:
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
