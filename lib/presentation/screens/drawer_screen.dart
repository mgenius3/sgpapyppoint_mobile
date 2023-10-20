import 'package:flutter/material.dart';
import 'package:sgpaypoint/presentation/routes.dart';
import '../../utils/mode.dart';
import '../theme/main_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../svg_icons/svg.dart';
import 'package:sgpaypoint/data/state/user.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AllTheme sgtheme = AllTheme();
    bool darkMode = isDarkMode(context);
    final user_details = Provider.of<UserState>(context, listen: false);

    return Drawer(
      backgroundColor: darkMode ? sgtheme.blackColor : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 80),
          Container(
            padding: EdgeInsets.only(left: 10, right: 20),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: sgtheme.cutomDarkColor,
                      child: Text("${user_details.user!.username[0]}"),
                    )),
                SizedBox(width: 20),
                Flexible(
                  flex: 2,
                  child: Column(children: [
                    Text(
                      "${user_details.user!.username}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: darkMode ? Colors.white : sgtheme.blackColor),
                    ),
                    Text("${user_details.user!.email}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: sgtheme.greyColor))
                  ]),
                )
              ],
            )),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 10, right: 20),
              children: <Widget>[
                ListTile(
                  iconColor:
                      darkMode ? sgtheme.cutomDarkColor : sgtheme.customColor,
                  leading: Icon(Icons.card_giftcard,
                      color: darkMode
                          ? sgtheme.cutomDarkColor
                          : sgtheme.customColor),
                  title: Text(
                    'Sell Giftcard',
                    style: TextStyle(
                        color: darkMode
                            ? sgtheme.cutomDarkColor
                            : sgtheme.customColor),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.sell_giftcard);
                  },
                ),
                ListTile(
                  iconColor:
                      darkMode ? sgtheme.cutomDarkColor : sgtheme.customColor,
                  leading: Icon(Icons.card_giftcard,
                      color: darkMode
                          ? sgtheme.cutomDarkColor
                          : sgtheme.customColor),
                  title: Text(
                    'Buy Giftcard',
                    style: TextStyle(
                        color: darkMode
                            ? sgtheme.cutomDarkColor
                            : sgtheme.customColor),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.buy_giftcard);
                  },
                ),
                ListTile(
                  iconColor:
                      darkMode ? sgtheme.cutomDarkColor : sgtheme.customColor,
                  leading: Icon(Icons.currency_bitcoin,
                      color: darkMode
                          ? sgtheme.cutomDarkColor
                          : sgtheme.customColor),
                  title: Text(
                    'Sell Crypto',
                    style: TextStyle(
                        color: darkMode
                            ? sgtheme.cutomDarkColor
                            : sgtheme.customColor),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.sell_crypto);
                  },
                ),
                ListTile(
                  iconColor:
                      darkMode ? sgtheme.cutomDarkColor : sgtheme.customColor,
                  leading: SvgPicture.string(Trade_alt,
                      color: darkMode
                          ? sgtheme.cutomDarkColor
                          : sgtheme.customColor),
                  title: Text(
                    'Buy Crypto',
                    style: TextStyle(
                        color: darkMode
                            ? sgtheme.cutomDarkColor
                            : sgtheme.customColor),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.buy_crypto);
                  },
                ),
                ListTile(
                  iconColor:
                      darkMode ? sgtheme.cutomDarkColor : sgtheme.customColor,
                  leading: Icon(Icons.phone,
                      color: darkMode
                          ? sgtheme.cutomDarkColor
                          : sgtheme.customColor),
                  title: Text(
                    'Airtime',
                    style: TextStyle(
                        color: darkMode
                            ? sgtheme.cutomDarkColor
                            : sgtheme.customColor),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.airtime);
                  },
                ),
                ListTile(
                  iconColor:
                      darkMode ? sgtheme.cutomDarkColor : sgtheme.customColor,
                  leading: SvgPicture.string(Deposit,
                      color: darkMode
                          ? sgtheme.cutomDarkColor
                          : sgtheme.customColor),
                  title: Text(
                    'Deposit',
                    style: TextStyle(
                        color: darkMode
                            ? sgtheme.cutomDarkColor
                            : sgtheme.customColor),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded, size: 15),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.deposit);
                  },
                ),
                ListTile(
                  iconColor:
                      darkMode ? sgtheme.cutomDarkColor : sgtheme.customColor,
                  leading: SvgPicture.string(Redraw,
                      color: darkMode
                          ? sgtheme.cutomDarkColor
                          : sgtheme.customColor),
                  title: Text(
                    'Withdraw',
                    style: TextStyle(
                        color: darkMode
                            ? sgtheme.cutomDarkColor
                            : sgtheme.customColor),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.withdraw);
                  },
                ),
                ListTile(
                  iconColor:
                      darkMode ? sgtheme.cutomDarkColor : sgtheme.customColor,
                  leading: SvgPicture.string(Cables,
                      color: darkMode
                          ? sgtheme.cutomDarkColor
                          : sgtheme.customColor),
                  title: Text(
                    'Cables',
                    style: TextStyle(
                        color: darkMode
                            ? sgtheme.cutomDarkColor
                            : sgtheme.customColor),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.cable);
                  },
                ),
                ListTile(
                  iconColor:
                      darkMode ? sgtheme.cutomDarkColor : sgtheme.customColor,
                  leading: SvgPicture.string(Data,
                      color: darkMode
                          ? sgtheme.cutomDarkColor
                          : sgtheme.customColor),
                  title: Text(
                    'Data',
                    style: TextStyle(
                        color: darkMode
                            ? sgtheme.cutomDarkColor
                            : sgtheme.customColor),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.data);
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    user_details.clearUserData();
                    Navigator.pushNamed(context, AppRoutes.signin);
                  },
                  child: Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0,
                              color: darkMode
                                  ? sgtheme.cutomDarkColor
                                  : sgtheme.customColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sign Out",
                              style: TextStyle(
                                  color: darkMode
                                      ? sgtheme.cutomDarkColor
                                      : sgtheme.customColor),
                            ),
                            SvgPicture.string(SignOut)
                          ])),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
