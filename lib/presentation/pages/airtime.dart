import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import 'package:sgpaypoint/data/state/user.dart';
import 'package:provider/provider.dart';
import 'package:sgpaypoint/utils/helpers.dart';
import 'package:sgpaypoint/services/api_service.dart';

class AirtimePurchase extends StatefulWidget {
  const AirtimePurchase({super.key});

  @override
  _AirtimePurchaseState createState() => _AirtimePurchaseState();
}

class _AirtimePurchaseState extends State<AirtimePurchase> {
  int dialog_display_index = 0;
  bool display_dialog = false;
  AllTheme sgtheme = AllTheme();
  Services api = Services();
  bool _isloading = false;

  final _amountTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  //declare a Global key
  final _formkey = GlobalKey<FormState>();

  Map dialog_display = {
    "airtime_name": ["MTN", "AIRTEL", "GLO", "9MOBILE"],
    "airtime_logo": [
      "mtn-removebg-preview.png",
      "airtel-removebg-preview.png",
      "glo-removebg-preview.png",
      "9mobile-removebg-preview.png",
    ],
  };

  _submit() async {
    try {
      if (_formkey.currentState!.validate()) {
        setState(() {
          _isloading = true;
        });

        String network = (dialog_display["airtime_name"][dialog_display_index])
            .toString()
            .toLowerCase();
        String amount = _amountTextController.text.trim();
        String phone = _phoneTextController.text.trim();

        await api.Get(
          "https://www.nellobytesystems.com/APIAirtimeV1.asp?UserID=CK100416304&APIKey=TRW301I60WYO3VZEN4WR10OO50KS4421S3Y5KV3RK610894IRVDH3957K2D7L81A&MobileNetwork=$network&Amount=$amount&MobileNumber=$phone&RequestID=123&CallBackURL=https://sgpaypoint.com.ng",
        );

        setState(() {
          _isloading = false;
        });

        Fluttertoast.showToast(msg: 'airtime request is successfully');
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

      Fluttertoast.showToast(msg: "error unable to purchase airtime");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserState>(context, listen: false).user;

    return Scaffold(
      backgroundColor: Color.fromARGB(237, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "Airtime Purchase",
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
      body: Stack(
        children: [
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
                        width: screen_width * 0.4,
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
                            "public/images/mtn-removebg-preview.png",
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
                        width: screen_width * 0.4,
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
                            "public/images/airtel-removebg-preview.png",
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
                        width: screen_width * 0.4,
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
                            "public/images/glo-removebg-preview.png",
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          dialog_display_index = 3;
                          display_dialog = true;
                        });
                      },
                      child: Container(
                        width: screen_width * 0.4,
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
                            "public/images/9mobile-removebg-preview.png",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "public/images/${dialog_display["airtime_logo"][dialog_display_index]}",
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
                        SizedBox(height: 30),
                        Theme(
                          data: ThemeData(
                            inputDecorationTheme: InputDecorationTheme(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: sgtheme.customColor),
                              ),
                            ),
                          ),
                          child: TextFormField(
                            // focusNode: _nameFocusNode,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Amount (\u20A6)',
                              border:
                                  OutlineInputBorder(), // Set the border to a rectangular shape
                              focusColor: sgtheme.customColor,
                              hintText: 'Amount',
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
                                return 'Amount can\'t be empty';
                              }

                              if (text.length < 2) {
                                return "Please enter a valid amount";
                              }
                              if (double.parse(text) >
                                  double.parse(user!.naira_Wallet_Balance)) {
                                return "Insufficient Funds";
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
                                borderSide:
                                    BorderSide(color: sgtheme.customColor),
                              ),
                            ),
                          ),
                          child: TextFormField(
                            // focusNode: _nameFocusNode,
                            keyboardType: TextInputType.number,

                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border:
                                  OutlineInputBorder(), // Set the border to a rectangular shape
                              focusColor: sgtheme.customColor,
                              hintText: 'Phone Number',
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
                                return 'Phone Number can\'t be empty';
                              }

                              if (text.length < 2) {
                                return "Please enter a valid name";
                              }
                              if (text.length > 11) {
                                return 'Phone Number can\t be more than 11';
                              }
                            },
                            onChanged: (text) => setState(() {
                              _phoneTextController.text = text;
                            }),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: !_isloading ? _submit : null,
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: sgtheme.cutomDarkColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              !_isloading
                                  ? "Purchase ${dialog_display["airtime_name"][dialog_display_index]}"
                                  : "Purchasing ...",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))),
        ],
      ),
    );
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
