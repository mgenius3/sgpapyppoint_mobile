import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import 'package:sgpaypoint/services/api_service.dart';

class CablePurchase extends StatefulWidget {
  const CablePurchase({super.key});

  @override
  _CablePurchaseState createState() => _CablePurchaseState();
}

class _CablePurchaseState extends State<CablePurchase> {
  int dialog_display_index = 0;
  bool display_dialog = false;
  AllTheme sgtheme = AllTheme();
  final _formkey = GlobalKey<FormState>();
  bool _isloading = false;
  Services api = Services();

  final _packageBanquetController = TextEditingController();
  final _iucNumberController = TextEditingController();
  final _phoneController = TextEditingController();

  Map dialog_display = {
    "cable_name": ["GOTV", "DSTV", "STARTIMES"],
    "cable_logo": [
      "gotv-removebg-preview.png",
      "dstv-removebg-preview.png",
      "startimes-removebg-preview.png",
    ],
    "cable_subscription": [
      [
        "GOtv Smallie-Monthly N800",
        "GOtv Smallie-Quaterly N2100",
        "GOtv Smallie-Yearly N6200",
        "GOtv Jinja  N1,640",
        "GOtv Jolli N2,460",
        "Gotv Max N3600"
      ],
      [
        "DStv Padi N1850",
        "DStv Yanga N2,565",
        "Dstv Confam N4,615",
        "DStv Compact N7900",
        "DStv Compact Plus N12400",
        "DStv Premium N18400",
        "DStv Asia N6,2005,540",
        "DStv Premium-French N25,550"
      ],
      [
        "Startimes Nova - 900 Naira",
        "Startimes Basic - 1,700 Naira",
        "Startimes Smart - 2,200 Naira",
        "Startimes Classic - 2,500 Naira",
        "Super - 4,200 Naira - 1 Month",
      ]
    ]
  };

  _submit() async {
    try {
      if (_formkey.currentState!.validate()) {
        setState(() {
          _isloading = true;
        });

        String cabletvcode = (dialog_display["cable_name"]
                [dialog_display_index])
            .toString()
            .toLowerCase();

        final packagecode = _packageBanquetController.text.trim();
        final smartcardno = _iucNumberController.text.trim();
        final phoneno = _phoneController.text.trim();

        await api.Get(
            'https://www.nellobytesystems.com/APICableTVV1.asp?UserID=CK100416304&APIKey=TRW301I60WYO3VZEN4WR10OO50KS4421S3Y5KV3RK610894IRVDH3957K2D7L81A&CableTV=$cabletvcode&Package=$packagecode&SmartCardNo=$smartcardno&PhoneNo=$phoneno&RequestID=123&CallBackURL=https://sgpaypoint.com.ng');

        setState(() {
          _isloading = false;
        });

        Fluttertoast.showToast(msg: 'cabletv request is successfully');
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

      Fluttertoast.showToast(msg: "error unable to purchase cabletv");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;

    List<DropdownMenuItem<String>> dropdownItems =
        dialog_display["cable_subscription"][dialog_display_index]
            .map<DropdownMenuItem<String>>((data) {
      return DropdownMenuItem<String>(
        value: data,
        child: Text(data),
      );
    }).toList();

    return Scaffold(
      backgroundColor: Color.fromARGB(237, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "Cable TV Subscription",
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
                            "public/images/gotv-removebg-preview.png",
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
                            "public/images/dstv-removebg-preview.png",
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
                            "public/images/startimes-removebg-preview.png",
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
                              "public/images/${dialog_display["cable_logo"][dialog_display_index]}",
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
                        DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText:
                                  "Select ${dialog_display["cable_name"][dialog_display_index]} Banquet",
                              labelText:
                                  '${dialog_display["cable_name"][dialog_display_index]} Banquet',
                              labelStyle:
                                  TextStyle(color: sgtheme.cutomDarkColor),
                              // prefixIcon: Icon(Icons.taxi_alert),
                              border: OutlineInputBorder(),
                            ),
                            items: dropdownItems,
                            onChanged: (String? value) {
                              setState(
                                () {
                                  _packageBanquetController.text = value!;
                                },
                              );
                            }),
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
                            // keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'SmartCard/IUC NUMBER',
                              border:
                                  OutlineInputBorder(), // Set the border to a rectangular shape
                              focusColor: sgtheme.customColor,
                              hintText: 'SmartCard/IUC NUMBER',
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
                                return 'SmartCard/IUC NUMBER can\'t be empty';
                              }

                              if (text.length < 1) {
                                return "Please enter a valid smartcard/IUC NUMBER";
                              }
                            },
                            onChanged: (text) => setState(() {
                              _iucNumberController.text = text;
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

                              if (text.length < 11) {
                                return "Please enter a valid phonenumber";
                              }
                            },
                            onChanged: (text) => setState(() {
                              _phoneController.text = text;
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
                                  ? "Proceed Purchase of ${dialog_display["cable_name"][dialog_display_index]} Banquet"
                                  : "Purchasing...",
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
