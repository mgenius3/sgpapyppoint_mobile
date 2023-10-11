import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import 'package:file_picker/file_picker.dart';
import "dart:io";
import 'package:sgpaypoint/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:sgpaypoint/utils/helpers.dart';
import 'package:sgpaypoint/data/global/constant.dart';
import 'package:sgpaypoint/data/state/user.dart';
import '../routes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Deposit extends StatefulWidget {
  const Deposit({super.key});

  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  AllTheme sgtheme = AllTheme();
  Services api = Services();
  bool _isloading = false;
  File? selectedFile;
  //declare a Global key
  final _formkey = GlobalKey<FormState>();
  final _amountTextController = TextEditingController();
  final _NotesTextController = TextEditingController();

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        selectedFile = file;
      });
    }
  }

  // void _submit() async {
  //   try {
  //     if (_formkey.currentState!.validate()) {
  //       setState(() {
  //         _isloading = true;
  //       });

  //       Map<String, dynamic> userMap = {
  //         "amount": _amountTextController.text.trim(),
  //         "description": _NotesTextController.text.trim(),
  //         "file": selectedFile
  //       };

  //       final user_details =
  //           Provider.of<UserState>(context, listen: false).user;

  //       var response = api.Post(
  //           "$endpoint/deposit.php?username=${user_details!.username}&email=${user_details!.email}&amount=${userMap['amount']}&ufile=${userMap['file']}&description=${userMap['description']}",
  //           {});

  //       String errorMessage = refactor_response_obj(response)['error'];

  //       if (errorMessage.isNotEmpty) {
  //         setState(() {
  //           _isloading = false;
  //         });
  //         Fluttertoast.showToast(msg: errorMessage);
  //       } else {
  //         Fluttertoast.showToast(msg: "deposit successful");
  //         Navigator.pop(context);
  //       }
  //     } else {
  //       setState(() {
  //         _isloading = false;
  //       });
  //     }
  //   } catch (err) {
  //     print(err);
  //     Fluttertoast.showToast(msg: "Unable to make deposit, please try again!");
  //     setState(() {
  //       _isloading = false;
  //     });
  //   }
  // }

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
          Uri.parse("$endpoint/deposit.php"),
        );

        // Add form fields
        request.fields['username'] = user_details!.username;
        request.fields['email'] = user_details!.email;
        request.fields['amount'] = _amountTextController.text.trim();
        request.fields['description'] = _NotesTextController.text.trim();

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
          Fluttertoast.showToast(msg: "Deposit successful");
        } else {
          // Request failed
          setState(() {
            _isloading = false;
          });
          print(responseData);
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
    double screen_width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(237, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "Deposit",
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
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(Icons.notifications, color: Colors.white),
                              Expanded(
                                  child: RichText(
                                      text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Account Number: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '4011468577\n\n',
                                      style: TextStyle(
                                          color: sgtheme.cutomDarkColor)),
                                  TextSpan(
                                      text: 'Account Name: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          'Saint SG Business Services Limited\n\n',
                                      style:
                                          TextStyle(color: sgtheme.greyColor)),
                                  TextSpan(
                                      text: 'Bank: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'Fidelity Bank',
                                      style:
                                          TextStyle(color: sgtheme.greyColor)),
                                ],
                              )))
                            ],
                          ),
                          Divider(thickness: 1, color: Colors.grey[200]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(Icons.notifications, color: Colors.white),
                              Expanded(
                                  child: RichText(
                                      text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Account Number: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '8214162691\n\n',
                                      style: TextStyle(
                                          color: sgtheme.cutomDarkColor)),
                                  TextSpan(
                                      text: 'Account Name: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          'Saint SG Business Services Limited\n\n',
                                      style:
                                          TextStyle(color: sgtheme.greyColor)),
                                  TextSpan(
                                      text: 'Bank: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'Wema Bank',
                                      style:
                                          TextStyle(color: sgtheme.greyColor)),
                                ],
                              )))
                            ],
                          ),
                          Divider(thickness: 1, color: Colors.grey[200]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(Icons.notifications, color: Colors.white),
                              Expanded(
                                  child: RichText(
                                      text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Account Number: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '8267246361\n\n',
                                      style: TextStyle(
                                          color: sgtheme.cutomDarkColor)),
                                  TextSpan(
                                      text: 'Account Name: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          'Saint SG Business Services Limited\n\n',
                                      style:
                                          TextStyle(color: sgtheme.greyColor)),
                                  TextSpan(
                                      text: 'Bank: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'Moniepoint',
                                      style:
                                          TextStyle(color: sgtheme.greyColor)),
                                ],
                              )))
                            ],
                          ),
                        ],
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
                              borderSide:
                                  BorderSide(color: sgtheme.customColor),
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
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Notes',
                          border:
                              OutlineInputBorder(), // Set the border to a rectangular shape
                          focusColor: sgtheme.customColor,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 56.0,
                              horizontal: 10), // Adjust the padding here
                          hintText: 'Notes',
                          labelStyle: TextStyle(
                              // color: _nameFocusNode.hasFocus
                              //     ? sgtheme.customColor
                              //     : Colors.black,
                              color: sgtheme.cutomDarkColor),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Notes can\'t be empty';
                          }

                          if (text.length < 2) {
                            return "Please enter a valid name";
                          }
                          if (text.length > 99) {
                            return 'Notes can\t be more than 50';
                          }
                        },
                        onChanged: (text) => setState(() {
                          _NotesTextController.text = text;
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
                          !_isloading ? "Make Deposit" : "Please wait ...",
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
          )
        ],
      ),
    );
  }
}
