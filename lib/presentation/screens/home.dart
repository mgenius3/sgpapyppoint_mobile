import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sgpaypoint/data/models/trade_value.dart';
import 'package:sgpaypoint/utils/mode.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import 'dart:ui';
import './drawer_screen.dart';
import '../routes.dart';
import '../../services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:sgpaypoint/data/state/trade_value.dart';
import 'package:sgpaypoint/data/state/user.dart';

import '../svg_icons/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sgpaypoint/utils/helpers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isBalanceVisible = true;
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  final AllTheme sgtheme = AllTheme();

  Future<void> fetchCryptoData() async {
    List<dynamic> bitcoin_data =
        await Services().fetchCryptoPriceData("bitcoin") as List<dynamic>;
    Provider.of<TradeValueState>(context, listen: false)
        .updateBitcoinData(bitcoin_data);

    List<dynamic> ethereum_data =
        await Services().fetchCryptoPriceData("ethereum") as List<dynamic>;
    Provider.of<TradeValueState>(context, listen: false)
        .updateEthereumData(ethereum_data);

    List<dynamic> tether_data =
        await Services().fetchCryptoPriceData("tether") as List<dynamic>;
    Provider.of<TradeValueState>(context, listen: false)
        .updateTetherData(tether_data);
  }

  bool showChatBox = false;

  void toggleChat() {
    setState(() {
      showChatBox = !showChatBox;
    });
  }

  void initState() {
    fetchCryptoData();
  }

  @override
  Widget build(BuildContext context) {
    bool darkmode = isDarkMode(context);
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    final user_details = Provider.of<UserState>(context, listen: false);

    return Scaffold(
        key: _scaffoldState,
        drawer: DrawerScreen(),
        backgroundColor: darkmode ? sgtheme.blackHomeColor : Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  "public/images/${darkmode ? 'dark_dash.png' : 'light_dash.png'}",
                  width: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
              ),
              Transform.translate(
                  offset: Offset(0, -screen_height * 0.27),
                  // left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  _scaffoldState.currentState!.openDrawer();
                                },
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: 40,
                                )),
                            GestureDetector(
                                onTap: null,
                                child: CircleAvatar(
                                  backgroundColor:
                                      darkmode ? Colors.white : Colors.black,
                                  child: Text(
                                      "${user_details.user!.username[0]}",
                                      style: TextStyle(
                                          color: darkmode
                                              ? Colors.black
                                              : Colors.white)),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 35),
                        child: Text(
                          "Welcome Back ${user_details.user!.username}",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ],
                  )),
              Container(
                child: Transform.translate(
                    offset: Offset(0, -120),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              // height: MediaQuery.of(context).size.height * 0.45,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: darkmode
                                    ? sgtheme.blackColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset:
                                        Offset(0, 2), // Offset of the shadow
                                    blurRadius:
                                        4.0, // Spread radius of the shadow
                                    spreadRadius:
                                        1.0, // Blur radius of the shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Wallet Balance",
                                    style: TextStyle(
                                        color: darkmode
                                            ? sgtheme.greyColor
                                            : sgtheme.blackColor,
                                        fontSize: 24),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _isBalanceVisible
                                            ? "\u20A6${user_details.user!.naira_Wallet_Balance}"
                                            : "******",
                                        style: TextStyle(
                                            color: darkmode
                                                ? Colors.white
                                                : sgtheme.blackColor,
                                            fontSize: 35,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _isBalanceVisible =
                                                  !_isBalanceVisible;
                                            });
                                          },
                                          child: Icon(
                                              _isBalanceVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: darkmode
                                                  ? Colors.white
                                                  : sgtheme.blackColor))
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: null,
                                    child: Text(
                                      "Wallet History",
                                      style: TextStyle(
                                          color: darkmode
                                              ? sgtheme.cutomDarkColor
                                              : sgtheme.customColor),
                                    ),
                                  ),
                                  Image.asset(
                                      "public/images/${darkmode ? 'light_tradeline.png' : 'dark_tradeline.png'}",
                                      fit: BoxFit.fill,
                                      width: screen_width,
                                      // height: screen_height * 0.12,
                                      height: 150),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Image.asset(
                        //   "public/images/${darkmode ? 'dark_makedep.png' : 'light_makedep.png'}",
                        //   fit: BoxFit.fill,
                        // )
                        Divider(
                          thickness: 0.1,
                          height: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 50,
                          runSpacing: 0.8,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.deposit);
                                },
                                child: Column(children: [
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: darkmode
                                              ? Colors.white
                                              : Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SvgPicture.string(Deposit,
                                          color: darkmode
                                              ? sgtheme.customColor
                                              : sgtheme.cutomDarkColor)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Deposit",
                                    style: TextStyle(
                                      color: darkmode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  )
                                ])),
                            GestureDetector(
                                onTap: null,
                                child: Column(children: [
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: darkmode
                                              ? Colors.white
                                              : Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SvgPicture.string(Redraw,
                                          width: 15,
                                          color: darkmode
                                              ? sgtheme.cutomDarkColor
                                              : sgtheme.customColor)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Withdraw",
                                    style: TextStyle(
                                      color: darkmode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  )
                                ])),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.sell_crypto);
                                },
                                child: Column(children: [
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: darkmode
                                              ? Colors.white
                                              : Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(Icons.currency_bitcoin,
                                          size: 20,
                                          color: darkmode
                                              ? sgtheme.cutomDarkColor
                                              : sgtheme.customColor)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Trade",
                                    style: TextStyle(
                                      color: darkmode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  )
                                ])),
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Visibility(
              visible: showChatBox,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: FloatingActionButton(
                  backgroundColor: darkmode ? sgtheme.blackColor : Colors.white,
                  onPressed: () {
                    // Navigator.pushNamed(context, AppRoutes.chat);
                    openWhatsApp();
                  },
                  child: Icon(FontAwesomeIcons.whatsapp,
                      color: darkmode
                          ? Colors.white
                          : Colors
                              .black), // Add a chat icon or any other icon you prefer
                ),
              ),
            ),
            Visibility(
              visible: showChatBox,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: FloatingActionButton(
                  backgroundColor: darkmode ? sgtheme.blackColor : Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.chat);
                  },
                  child: Icon(Icons.chat,
                      color: darkmode
                          ? Colors.white
                          : Colors
                              .black), // Add a chat icon or any other icon you prefer
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: FloatingActionButton(
                backgroundColor: darkmode ? sgtheme.blackColor : Colors.white,
                onPressed: () {
                  // Navigator.pushNamed(context, AppRoutes.chat);
                  toggleChat();
                },
                child: Icon(
                    showChatBox
                        ? FontAwesomeIcons.cancel
                        : FontAwesomeIcons.headphones,
                    color: darkmode
                        ? Colors.white
                        : Colors
                            .black), // Add a chat icon or any other icon you prefer
              ),
            ),
          ],
        ));
  }
}
