import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import "../routes.dart";
import 'package:provider/provider.dart';
import 'package:sgpaypoint/data/state/user.dart';
import 'package:sgpaypoint/services/api_service.dart';
import 'package:sgpaypoint/utils/helpers.dart';

class BuyCrypto extends StatefulWidget {
  const BuyCrypto({super.key});

  @override
  _BuyCryptoState createState() => _BuyCryptoState();
}

class _BuyCryptoState extends State<BuyCrypto> {
  int dialog_display_index = 0;
  bool display_dialog = false;
  AllTheme sgtheme = AllTheme();
  bool _isloading = false;
  Services api = Services();

  final _walletTextController = TextEditingController();
  final _amountTextController = TextEditingController();
  final _ownWalletTextController = TextEditingController();

  //declare a Global key
  final _formkey = GlobalKey<FormState>();

  Map dialog_display = {
    "crypto_name": ["BITCOIN", "ETHEREUM", "TETHER"],
    "crypto_logo": [
      "bitcoin-removebg-preview.png",
      "Ethereum-logo-removebg-preview.png",
      "tether2-removebg-preview.png"
    ],
  };

  _submit(crypto_name, String username) async {
    try {
      if (_formkey.currentState!.validate()) {
        setState(() {
          _isloading = true;
        });

        String network = (dialog_display["airtime_name"][dialog_display_index])
            .toString()
            .toLowerCase();
        String amount = _amountTextController.text.trim();
        String ownwallet = _ownWalletTextController.text.trim();
        String paywallet = _walletTextController.text.trim();

        var response = await api.Post(
            "http://sgpaypoint.com.ng/api/buycrypto.php?type=${crypto_name.toString().toLowerCase()}&username=$username&depositatm=$amount&paywallet=$paywallet&ownwallet=$ownwallet",
            {});

        String errorMessage = refactor_response_obj(response)['error'];

        if (errorMessage.isNotEmpty) {
          setState(() {
            _isloading = false;
          });
          Fluttertoast.showToast(msg: errorMessage);
        } else {
          Fluttertoast.showToast(msg: "successful");
        }

        setState(() {
          _isloading = false;
        });
      } else {
        setState(() {
          _isloading = false;
        });
        Fluttertoast.showToast(msg: "Please fill in all field currently");
      }
    } catch (err) {
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    final user_details = Provider.of<UserState>(context, listen: false).user;

    return Scaffold(
        backgroundColor: Color.fromARGB(237, 255, 255, 255),
        appBar: AppBar(
          title: Text(
            "Buy Crypto",
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
        body: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            //check if the swipe is from right to left
            if (details.primaryVelocity! > 0) {
              Navigator.pushNamed(context, AppRoutes.sell_crypto);
            } else if (details.primaryVelocity! > 0) {
              // Navigator.pop(context);
            }
          },
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: screen_width * 0.3,
                right: null,
                child: Row(children: [
                  // Icon(Icons.arrow_back),
                  Text(
                    "Swipe left to sell crypto",
                    style: TextStyle(
                        color: sgtheme.cutomDarkColor,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: SingleChildScrollView(
                  child: Center(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 0.8,
                      alignment: WrapAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              dialog_display_index = 0;
                              display_dialog = true;
                            });
                          },
                          child: Container(
                            width: screen_width * 0.7,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.asset(
                                "public/images/bitcoin-removebg-preview.png",
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              dialog_display_index = 1;
                              display_dialog = true;
                            });
                          },
                          child: Container(
                            width: screen_width * 0.7,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.asset(
                                "public/images/Ethereum-logo-removebg-preview.png",
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              dialog_display_index = 2;
                              display_dialog = true;
                            });
                          },
                          child: Container(
                            width: screen_width * 0.7,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.asset(
                                "public/images/tether2-removebg-preview.png",
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (display_dialog)
                Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    backgroundColor: Colors.white,
                    child: SingleChildScrollView(
                      child: Form(
                          key: _formkey,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "public/images/${dialog_display["crypto_logo"][dialog_display_index]}",
                                      width: 50,
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            display_dialog = false;
                                          });
                                        },
                                        icon: Icon(Icons.cancel),
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 30),
                                // Container(
                                //   padding: EdgeInsets.all(10),
                                //   decoration: BoxDecoration(
                                //     color: sgtheme.blackHomeColor,
                                //     borderRadius: BorderRadius.circular(5),
                                //   ),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       Icon(Icons.notifications,
                                //           color: Colors.white),
                                //       Expanded(
                                //         child: Text(
                                //           "Fill in amount you want to purchase and wallet address to receive:",
                                //           style: TextStyle(
                                //             color: Colors.white,
                                //           ),
                                //           softWrap: true,
                                //           overflow: TextOverflow.clip,
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                                SizedBox(height: 5),
                                DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      hintText: "Select Billing Wallet",
                                      labelText: 'Billing Wallet',
                                      labelStyle: TextStyle(
                                          color: sgtheme.cutomDarkColor),
                                      border: OutlineInputBorder(),
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                          child: Row(
                                            children: [
                                              // Icon(Icons.local_taxi),
                                              Text("Naira Wallet")
                                            ],
                                          ),
                                          value: "naira"),
                                      DropdownMenuItem(
                                          child: Row(children: [
                                            // Icon(Icons.motorcycle),
                                            Text("Bonus Wallet")
                                          ]),
                                          value: "bonus")
                                    ],
                                    onChanged: (String? value) {
                                      setState(
                                        () {
                                          _walletTextController.text = value!;
                                        },
                                      );
                                    }),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Our Rate:",
                                      style: TextStyle(
                                        color: sgtheme.cutomDarkColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "\u20A6750/dollar",
                                      style: TextStyle(
                                        color: sgtheme.blackHomeColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Theme(
                                  data: ThemeData(
                                    inputDecorationTheme: InputDecorationTheme(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: sgtheme.customColor),
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    // focusNode: _nameFocusNode,
                                    decoration: InputDecoration(
                                      labelText: 'Amount (\u20A6)',
                                      border:
                                          OutlineInputBorder(), // Set the border to a rectangular shape
                                      focusColor: sgtheme.customColor,
                                      hintText: 'Amount',
                                      labelStyle: TextStyle(
                                          color: sgtheme.cutomDarkColor),
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Amount can\'t be empty';
                                      }

                                      if (text.length <= 0) {
                                        return "Please enter a valid name";
                                      }
                                    },
                                    onChanged: (text) => setState(() {
                                      _amountTextController.text = text;
                                    }),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Theme(
                                  data: ThemeData(
                                    inputDecorationTheme: InputDecorationTheme(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: sgtheme.customColor),
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    // focusNode: _nameFocusNode,
                                    decoration: InputDecoration(
                                      labelText: 'Own Wallet (\u20A6)',
                                      border:
                                          OutlineInputBorder(), // Set the border to a rectangular shape
                                      focusColor: sgtheme.customColor,
                                      hintText: 'Own Wallet',
                                      labelStyle: TextStyle(
                                          // color: _nameFocusNode.hasFocus
                                          //     ? sgtheme.customColor
                                          //     : Colors.black,
                                          color: sgtheme.cutomDarkColor),
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Own Wallet can\'t be empty';
                                      }

                                      if (text.length < 2) {
                                        return "Please enter a valid name";
                                      }
                                      if (text.length > 99) {
                                        return 'Own Wallet can\t be more than 50';
                                      }
                                    },
                                    onChanged: (text) => setState(() {
                                      _ownWalletTextController.text = text;
                                    }),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: sgtheme.blackHomeColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.notifications,
                                          color: Colors.white),
                                      Expanded(
                                        child: Text(
                                          "Fill in the ${dialog_display["crypto_name"][dialog_display_index]} wallet address you want to receive your ${dialog_display["crypto_name"][dialog_display_index]}.",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.clip,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    _submit(
                                        dialog_display["crypto_name"]
                                            [dialog_display_index],
                                        user_details!.username);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: sgtheme.cutomDarkColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Buy ${dialog_display["crypto_name"][dialog_display_index]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )),
            ],
          ),
        ));
  }

  void _copyToClipboard(textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard'),
      ),
    );

    Fluttertoast.showToast(msg: "address copied");
  }

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
