import 'package:flutter/material.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';
import "dart:io";
import 'package:sgpaypoint/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:sgpaypoint/data/state/user.dart';
import 'package:sgpaypoint/data/global/constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SellCryptoConfirmation extends StatefulWidget {
  final crypto_name;
  const SellCryptoConfirmation({super.key, required this.crypto_name});

  @override
  State<SellCryptoConfirmation> createState() => _SellCryptoConfirmationState();
}

class _SellCryptoConfirmationState extends State<SellCryptoConfirmation> {
  // https://sgpaypoint.com.ng/api/sellcrypto.php?type=btc&ufile=IMG_2023rgirtr&username=nuel123&email=oluwaleyeolufemi@gmail.com&amount=1000&ownwallet=bc1kdvnroieorvdfvioervofd
  AllTheme sgtheme = AllTheme();
  File? selectedFile;
  bool _isloading = false;

  final _formkey = GlobalKey<FormState>();
  final _amountTextController = TextEditingController();
  final _ownWalletTextController = TextEditingController();

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        selectedFile = file;
      });
    }
  }

  void _submit() async {
    try {
      if (_formkey.currentState!.validate()) {
        setState(() {
          _isloading = true;
        });

        final user_details =
            Provider.of<UserState>(context, listen: false).user;

        // Create a multipart request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse("$endpoint/sellcrypto.php"),
        );

        // Add form fields
        request.fields['type'] = widget.crypto_name.toString().toLowerCase();
        request.fields['username'] = user_details!.username;
        request.fields['email'] = user_details!.email;
        request.fields['amount'] = _amountTextController.text.trim();
        request.fields['ownwallet'] = _ownWalletTextController.text.trim();

        // Add the file to the request
        if (selectedFile != null) {
          final fileStream =
              http.ByteStream(Stream.castFrom(selectedFile!.openRead()));
          final length = await selectedFile!.length();
          request.files.add(
            http.MultipartFile(
              'ufile',
              fileStream,
              length,
              filename: selectedFile!.path.split('/').last,
            ),
          );
        }

        // Send the request and get the response
        var responseStream = await request.send();

        // Read and decode the response data
        var responseBody = await responseStream.stream.bytesToString();
        var responseData = json.decode(responseBody);
        // Handle the response
        if (responseStream.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "Sell ${widget.crypto_name} confirmation sent successfully");
          Fluttertoast.showToast(msg: "Once confirmed, you will be credited");
        } else {
          // Request failed
          setState(() {
            _isloading = false;
          });
          Fluttertoast.showToast(
              msg: "Deposit failed:  ${responseData['message']}");
        }
      } else {
        setState(() {
          _isloading = false;
        });
      }
    } catch (err) {
      Fluttertoast.showToast(msg: "Unable to make deposit, please try again!");
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen_height = MediaQuery.of(context).size.height;
    final screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sell Crypto"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          // margin: EdgeInsets.only(top: 20),
          // height: screen_height,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   padding: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     color: Colors.black87,
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   child: Column(
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           // Icon(Icons.notifications, color: Colors.white),
                //           Expanded(
                //               child: RichText(
                //                   text: TextSpan(
                //             children: <TextSpan>[
                //               TextSpan(
                //                   text: 'Account Number: ',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold)),
                //               TextSpan(
                //                   text: '4011468577\n\n',
                //                   style: TextStyle(
                //                       color: sgtheme.cutomDarkColor)),
                //               TextSpan(
                //                   text: 'Account Name: ',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold)),
                //               TextSpan(
                //                   text:
                //                       'Saint SG Business Services Limited\n\n',
                //                   style:
                //                       TextStyle(color: sgtheme.greyColor)),
                //               TextSpan(
                //                   text: 'Bank: ',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold)),
                //               TextSpan(
                //                   text: 'Fidelity Bank',
                //                   style:
                //                       TextStyle(color: sgtheme.greyColor)),
                //             ],
                //           )))
                //         ],
                //       ),
                //       Divider(thickness: 1, color: Colors.grey[200]),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           // Icon(Icons.notifications, color: Colors.white),
                //           Expanded(
                //               child: RichText(
                //                   text: TextSpan(
                //             children: <TextSpan>[
                //               TextSpan(
                //                   text: 'Account Number: ',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold)),
                //               TextSpan(
                //                   text: '8214162691\n\n',
                //                   style: TextStyle(
                //                       color: sgtheme.cutomDarkColor)),
                //               TextSpan(
                //                   text: 'Account Name: ',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold)),
                //               TextSpan(
                //                   text:
                //                       'Saint SG Business Services Limited\n\n',
                //                   style:
                //                       TextStyle(color: sgtheme.greyColor)),
                //               TextSpan(
                //                   text: 'Bank: ',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold)),
                //               TextSpan(
                //                   text: 'Wema Bank',
                //                   style:
                //                       TextStyle(color: sgtheme.greyColor)),
                //             ],
                //           )))
                //         ],
                //       ),
                //       Divider(thickness: 1, color: Colors.grey[200]),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           // Icon(Icons.notifications, color: Colors.white),
                //           Expanded(
                //               child: RichText(
                //                   text: TextSpan(
                //             children: <TextSpan>[
                //               TextSpan(
                //                   text: 'Account Number: ',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold)),
                //               TextSpan(
                //                   text: '8267246361\n\n',
                //                   style: TextStyle(
                //                       color: sgtheme.cutomDarkColor)),
                //               TextSpan(
                //                   text: 'Account Name: ',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold)),
                //               TextSpan(
                //                   text:
                //                       'Saint SG Business Services Limited\n\n',
                //                   style:
                //                       TextStyle(color: sgtheme.greyColor)),
                //               TextSpan(
                //                   text: 'Bank: ',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold)),
                //               TextSpan(
                //                   text: 'Moniepoint',
                //                   style:
                //                       TextStyle(color: sgtheme.greyColor)),
                //             ],
                //           )))
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 30),
                Theme(
                  data: ThemeData(
                    inputDecorationTheme: InputDecorationTheme(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: sgtheme.customColor),
                      ),
                    ),
                  ),
                  child: TextFormField(
                    // focusNode: _nameFocusNode,
                    cursorColor: sgtheme.customColor,

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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Amount can\'t be empty';
                      }

                      if (text.length < 2) {
                        return "Please enter a valid name";
                      }
                      if (text.length > 99) {
                        return 'Amount can\t be more than 50';
                      }
                    },
                    onChanged: (text) => setState(() {
                      _amountTextController.text = text;
                    }),
                  ),
                ),
                SizedBox(height: 30),
                Theme(
                  data: ThemeData(
                    inputDecorationTheme: InputDecorationTheme(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: sgtheme.customColor),
                      ),
                    ),
                  ),
                  child: TextFormField(
                    // focusNode: _nameFocusNode,
                    cursorColor: sgtheme.customColor,

                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'own wallet (\u20A6)',
                      border:
                          OutlineInputBorder(), // Set the border to a rectangular shape
                      focusColor: sgtheme.customColor,
                      hintText: 'own wallet',
                      labelStyle: TextStyle(
                          // color: _nameFocusNode.hasFocus
                          //     ? sgtheme.customColor
                          //     : Colors.black,
                          color: sgtheme.cutomDarkColor),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'own wallet can\'t be empty';
                      }

                      if (text.length < 2) {
                        return "Please enter a valid name";
                      }
                    },
                    onChanged: (text) => setState(() {
                      _ownWalletTextController.text = text;
                    }),
                  ),
                ),
                SizedBox(height: 30),
                Theme(
                    data: ThemeData(
                      inputDecorationTheme: InputDecorationTheme(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: sgtheme.customColor),
                        ),
                      ),
                    ),
                    child: TextFormField(
                      // focusNode: _nameFocusNode,
                      cursorColor: sgtheme.customColor,

                      onTap: _openFilePicker,
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                        labelText: 'Payment Receipt',
                        border:
                            OutlineInputBorder(), // Set the border to a rectangular shape
                        focusColor: sgtheme.customColor,
                        hintText: 'upload file',
                        suffixIcon: Icon(Icons.attach_file_sharp),
                        labelStyle: TextStyle(
                            // color: _nameFocusNode.hasFocus
                            //     ? sgtheme.customColor
                            //     : Colors.black,
                            color: sgtheme.cutomDarkColor),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    )),
                SizedBox(height: 8.0),
                Text(selectedFile != null
                    ? selectedFile!.path
                    : 'No file selected'),
                SizedBox(height: 20),
                // Theme(
                //   data: ThemeData(
                //     inputDecorationTheme: InputDecorationTheme(
                //       floatingLabelBehavior: FloatingLabelBehavior.always,
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: sgtheme.customColor),
                //       ),
                //     ),
                //   ),
                //   child: TextFormField(
                //     // focusNode: _nameFocusNode,
                //     cursorColor: sgtheme.customColor,
                //     keyboardType: TextInputType.text,
                //     maxLines: null,
                //     decoration: InputDecoration(
                //       labelText: 'Notes',
                //       border:
                //           OutlineInputBorder(), // Set the border to a rectangular shape
                //       focusColor: sgtheme.customColor,
                //       contentPadding: EdgeInsets.symmetric(
                //           vertical: 56.0,
                //           horizontal: 10), // Adjust the padding here
                //       hintText: 'Notes',
                //       labelStyle: TextStyle(
                //           // color: _nameFocusNode.hasFocus
                //           //     ? sgtheme.customColor
                //           //     : Colors.black,
                //           color: sgtheme.cutomDarkColor),
                //     ),
                //     autovalidateMode: AutovalidateMode.onUserInteraction,
                //     validator: (text) {
                //       if (text == null || text.isEmpty) {
                //         return 'Notes can\'t be empty';
                //       }

                //       if (text.length < 2) {
                //         return "Please enter a valid name";
                //       }
                //       if (text.length > 99) {
                //         return 'Notes can\t be more than 50';
                //       }
                //     },
                //     onChanged: (text) => setState(() {
                //       _NotesTextController.text = text;
                //     }),
                //   ),
                // ),
                // SizedBox(height: 20),
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
                          ? "Sell ${widget.crypto_name}"
                          : "Please wait ...",
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
      ),
    );
  }
}
