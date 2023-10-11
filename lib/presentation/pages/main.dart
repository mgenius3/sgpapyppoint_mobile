import 'package:flutter/material.dart';
import 'package:sgpaypoint/presentation/screens/home.dart';
import 'package:sgpaypoint/utils/mode.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import 'package:sgpaypoint/presentation/screens/profile.dart';
import 'package:sgpaypoint/presentation/screens/trade.dart';
import 'package:sgpaypoint/presentation/pages/trade_giftcard.dart';
import 'package:sgpaypoint/presentation/pages/airtime.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final AllTheme sgtheme = AllTheme();
  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    return Scaffold(
      body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            HomePage(),
            TradePage(),
            TradeGiftCard(),
            AirtimePurchase(),
            ProfilePage(),
          ]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.currency_bitcoin), label: "Trade"),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: "Giftcards"),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: "Airtime"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        unselectedItemColor: darkMode ? Colors.white : sgtheme.blackColor,
        selectedItemColor:
            darkMode ? sgtheme.cutomDarkColor : sgtheme.customColor,
        backgroundColor: darkMode ? sgtheme.blackColor : Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
    );
  }
}
