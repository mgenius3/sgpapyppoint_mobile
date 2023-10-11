import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import "../routes.dart";
import 'package:sgpaypoint/services/api_service.dart';

class SellCrpto extends StatefulWidget {
  const SellCrpto({super.key});

  @override
  _SellCrptoState createState() => _SellCrptoState();
}

class _SellCrptoState extends State<SellCrpto> {
  int dialog_display_index = 0;
  bool display_dialog = false;
  AllTheme sgtheme = AllTheme();
  Services api = Services();

  Map dialog_display = {
    "crypto_name": ["BTC", "ETHEREUM", "TETHER"],
    "crypto_logo": [
      "bitcoin-removebg-preview.png",
      "Ethereum-logo-removebg-preview.png",
      "tether2-removebg-preview.png"
    ],
    "qrcode_img_link": [
      "btc_qrcode.png",
      "ethereum_qrcode.png",
      "tether_qrcode.png"
    ],
    "wallet_addresses": [
      "3JnB4Ykd9vixTqFWPQASAHXsee2DqRcfd",
      "0x2D78f53a3273dD105AB411e015cDE0BE07b6d8F0",
      "TAeP3UiuPYmia9bheyXmpzJxYNvtvP6XW2"
    ]
  };

  //  _submit() async {
  //   try {
  //     if (_formkey.currentState!.validate()) {
  //       setState(() {
  //         _isloading = true;
  //       });

  //       String network = (dialog_display["airtime_name"][dialog_display_index])
  //           .toString()
  //           .toLowerCase();
  //       String amount = _amountTextController.text.trim();
  //       String phone = _phoneTextController.text.trim();

  //       var response = await api.Post(
  //           "https://www.nellobytesystems.com/APIAirtimeV1.asp?UserID=CK100416304&APIKey=TRW301I60WYO3VZEN4WR10OO50KS4421S3Y5KV3RK610894IRVDH3957K2D7L81A&MobileNetwork=$network&Amount=$amount&MobileNumber=$phone&RequestID=123&CallBackURL=https://sgpaypoint.com.ng",
  //           {});

  //       setState(() {
  //         _isloading = false;
  //       });
  //     } else {
  //       setState(() {
  //         _isloading = false;
  //       });
  //       Fluttertoast.showToast(msg: "Please fill in all field currently");
  //     }
  //   } catch (err) {
  //     print(err);
  //     setState(() {
  //       _isloading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Color.fromARGB(237, 255, 255, 255),
        appBar: AppBar(
          title: Text(
            "Sell Crypto",
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
            //check if the swipe is from left to right
            if (details.primaryVelocity! < 0) {
              Navigator.pushNamed(context, AppRoutes.buy_crypto);
            } else if (details.primaryVelocity! > 0) {
              Navigator.pop(context);
            }
          },
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  left: screen_width * 0.3,
                  right: null,
                  child: Text("Swipe right to buy crypto",
                      style: TextStyle(
                          color: sgtheme.cutomDarkColor,
                          fontWeight: FontWeight.bold))),
              SizedBox(height: 20),
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
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Image.asset(
                          "public/images/${dialog_display["qrcode_img_link"][dialog_display_index]}",
                        ),
                        Text(
                          "Scan the QR code above or copy the TTH wallet address below to initiate your transaction",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            _copyToClipboard(dialog_display["wallet_addresses"]
                                [dialog_display_index]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: sgtheme.cutomDarkColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${dialog_display["wallet_addresses"][dialog_display_index]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Icon(Icons.copy_all),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
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
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: sgtheme.blackHomeColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.notifications, color: Colors.white),
                              Text(
                                "Our rates work with the crypto market rate,\nso we provide the best rates in the market.",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: sgtheme.cutomDarkColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Sell ${dialog_display["crypto_name"][dialog_display_index]}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
