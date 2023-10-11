import 'package:flutter/material.dart';
import 'package:sgpaypoint/presentation/routes.dart';
import 'package:sgpaypoint/presentation/theme/app_theme.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import 'package:sgpaypoint/presentation/pages/main.dart';
import 'package:sgpaypoint/presentation/pages/splash.dart';
import 'package:provider/provider.dart';
import 'package:sgpaypoint/data/state/trade_value.dart';
import 'package:sgpaypoint/data/state/user.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AllTheme paywavetheme = AllTheme();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TradeValueState()),
          ChangeNotifierProvider(create: (context) => UserState()),
        ],
        child: MaterialApp(
          title: 'SG',
          initialRoute: AppRoutes.splash, // Define the initial route
          onGenerateRoute: AppRoutes.generateRoute, // Set the route generator
          // // Add theme and other configurations as needed
          theme: appTheme,
          home: WillPopScope(
            onWillPop: () async {
              // Navigate to the home screen
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
              return false; // Return false to prevent the default back button behavior
            },
            child: Splash(),
          ),
        ));
  }
}
