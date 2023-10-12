import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:sgpaypoint/presentation/theme/main_theme.dart';

class AmexGiftCardScreen extends StatefulWidget {
  const AmexGiftCardScreen({super.key});

  @override
  State<AmexGiftCardScreen> createState() => _AmexGiftCardScreenState();
}

class _AmexGiftCardScreenState extends State<AmexGiftCardScreen> {
  AllTheme sgtheme = AllTheme();
  File? selectedFile;
  final FocusNode _amountFocusNode = FocusNode();
  final _amountTextController = TextEditingController();
  bool _isFocused = false;
  final List<int> dropDownValues =
      List.generate(10, (index) => (index + 1) * 5);

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        selectedFile = file;
      });
    }
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _amountFocusNode.hasFocus;
    });
  }

  void initState() {
    super.initState();
    // Add listener to _emailFocusNode and _passwordFocusNode
    _amountFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _amountFocusNode.removeListener(_onFocusChange);
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Trade AMEX Gift Card",
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: Icon(Icons
                .cancel), // Use Icons.arrow_back for the left-pointing arrow
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "public/images/america_express_logo-removebg-preview.png",
                  width: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Buying Rate:",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: sgtheme.cutomDarkColor),
                    ),
                    SizedBox(width: 5),
                    Text("#900/Dollar",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: sgtheme.blackColor))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Theme(
                  data: ThemeData(
                    inputDecorationTheme: InputDecorationTheme(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: sgtheme.customColor),
                      ),
                    ),
                  ),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: 'Amount',
                          labelStyle: TextStyle(
                            color: _amountFocusNode.hasFocus
                                ? sgtheme.customColor
                                : Colors.black,
                          ),
                          // prefixIcon: Icon(Icons.taxi_alert),
                          border: OutlineInputBorder(),
                          hintText: "Select Provider"),
                      items: dropDownValues.map((value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('\$$value'),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        setState(
                          () {
                            // ride = value;
                          },
                        );
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: InkWell(
                    onTap: _openFilePicker,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Documents',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Icon(Icons.attach_file),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: null,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: screen_width * 0.9,
                    decoration: BoxDecoration(
                        color: sgtheme.cutomDarkColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Trade AMEX Gift Cards ",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
