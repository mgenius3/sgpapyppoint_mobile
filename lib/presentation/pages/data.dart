import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import 'package:sgpaypoint/utils/helpers.dart';
import 'package:sgpaypoint/services/api_service.dart';

class DataPurchase extends StatefulWidget {
  const DataPurchase({super.key});

  @override
  _DataPurchaseState createState() => _DataPurchaseState();
}

class _DataPurchaseState extends State<DataPurchase> {
  int dialog_display_index = 0;
  bool display_dialog = false;
  AllTheme sgtheme = AllTheme();
  bool _isloading = false;
  Services api = Services();
  final _dataplanTextController = TextEditingController();
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
    "data_bundle": [
      [
        "\u20A6130 500MB - 30days",
        "\u20A6240 1GB - 30days",
        "\u20A6480 2GB - 30days",
        "\u20A6685 3GB - 30days",
        "\u20A61170 5GB - 30days",
        "\u20A62300 10GB - 30days"
      ],
      [
        "\u20A6128 500MB - 30days",
        "\u20A6230 1GB - 30days",
        "\u20A6460 2GB - 30days",
        "\u20A61130 5GB - 30days",
        "\u20A62250 10GB - 30days"
      ],
      [
        "\u20A6135 500MB - 30days",
        "\u20A6255 1GB - 30days",
        "\u20A6510 2GB - 30days",
        "\u20A6752 3GB - 30days",
        "\u20A61352 5GB - 30days",
        "\u20A62510 10GB - 30days"
      ],
      [
        "\u20A650 25MB - 24hrs",
        "\u20A6100 500MB - 30days",
        "\u20A6180 1GB - 30days",
        "\u20A6355 2GB - 30days",
        "\u20A6520 3GB - 30days",
        "\u20A6695 4GB - 30days",
        "\u20A6860 5GB - 30days",
        "\u20A61800 10GB - 30days"
      ]
    ]
  };

  _submit() async {
    try {
      if (_dataplanTextController.text.isNotEmpty &&
          _phoneTextController.text.isNotEmpty) {
        setState(() {
          _isloading = true;
        });

        String network = (dialog_display["airtime_name"][dialog_display_index])
            .toString()
            .toLowerCase();
        String dataplan = _dataplanTextController.text.trim();
        String phone = _phoneTextController.text.trim();

        late String ncode;

        if (network.toLowerCase() == 'mtn') {
          ncode = "01";
        } else if (network.toLowerCase() == 'glo') {
          ncode = "02";
        } else if (network.toLowerCase() == '9mobile') {
          ncode = "03";
        } else if (network.toLowerCase() == 'airtel') {
          ncode = "04";
        }

        await api.Get(
            "https://www.nellobytesystems.com/APIDatabundleV1.asp?UserID=CK100416304&APIKey=TRW301I60WYO3VZEN4WR10OO50KS4421S3Y5KV3RK610894IRVDH3957K2D7L81A&MobileNetwork=$ncode&DataPlan=$dataplan&MobileNumber=$phone&RequestID=123&CallBackURL=https://sgpaypoint.com.ng");

        setState(() {
          _isloading = false;
        });

        Fluttertoast.showToast(msg: 'Data request is successfully');
        _dataplanTextController.clear();
        _phoneTextController.clear();
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
      _dataplanTextController.clear();
      _phoneTextController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;

    List<DropdownMenuItem<String>> dropdownItems = dialog_display["data_bundle"]
            [dialog_display_index]
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
          "Data Purchase",
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
                        DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText: "Select Data Bundle",
                              labelText: 'Data Bundle',
                              labelStyle:
                                  TextStyle(color: sgtheme.cutomDarkColor),
                              // prefixIcon: Icon(Icons.taxi_alert),
                              border: OutlineInputBorder(),
                            ),
                            items: dropdownItems,
                            onChanged: (String? value) {
                              setState(
                                () {
                                  _dataplanTextController.text = value!;
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

                              if (text.length < 1) {
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
                                  ? "Purchase ${dialog_display["airtime_name"][dialog_display_index]} Data"
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
                )),
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
