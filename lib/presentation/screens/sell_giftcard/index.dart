import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:sgpaypoint/utils/helpers.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:sgpaypoint/data/state/user.dart';

class SellGiftCardScreen extends StatefulWidget {
  final giftcard_name, image_url;
  SellGiftCardScreen(
      {super.key, required this.giftcard_name, required this.image_url});

  @override
  State<SellGiftCardScreen> createState() => _SellGiftCardScreenState();
}

class _SellGiftCardScreenState extends State<SellGiftCardScreen> {
  AllTheme sgtheme = AllTheme();
  File? selectedFile;
  String? selectedFileName;
  var dollar_to_naira;
  final FocusNode _amountFocusNode = FocusNode();
  final _amountTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  bool _isFocused = false;
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final List<int> dropDownValues = [50, 100, 200, 1000];

  String? getFileName(File file) {
    // Get the file path.
    String filePath = file.path;

    // Use the path package to extract the filename.
    List<String> pathParts = filePath.split('/');
    String fileName = pathParts.last;

    return fileName;
  }

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String? fileName = getFileName(file);

      setState(() {
        selectedFile = file;
        selectedFileName = fileName;
      });
    }
  }

  void fetchdollarprice() async {
    int value = await fetchCurrentDollarPrice();
    setState(() {
      dollar_to_naira = value;
    });
  }

  _submit(user) async {
    // Now, save the URL and other data to Firebase Realtime Database
    final selectedAmount = _amountTextController.text.isNotEmpty
        ? int.parse(_amountTextController.text)
        : null;

    try {
      if (_formkey.currentState!.validate() &&
          selectedFile != null &&
          selectedAmount != null) {
        // Generate a unique filename for the file in Firebase Storage
        setState(() {
          _isLoading = true;
        });

        String fileName = DateTime.now().toIso8601String();
        Reference storageReference =
            _firebaseStorage.ref().child('receipts/$fileName');

        // Upload the selected file to Firebase Storage
        UploadTask uploadTask = storageReference.putFile(selectedFile!);

        // Wait for the upload to complete
        TaskSnapshot taskSnapshot = await uploadTask;

        // Get the download URL for the uploaded file
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        String emailAddress = _emailTextController.text;

        String databasePath = "sellGiftcard";

        Map<String, dynamic> purchaseData = {
          "username": user.username,
          "giftcard_name": "${widget.giftcard_name}",
          "amount_in_dollars": selectedAmount,
          "email": user.email,
          "receiptFileUrl": downloadUrl, // Save the download URL
        };

        _databaseReference.child(databasePath).push().set(purchaseData);
        setState(() {
          _isLoading = false;
        });

        Fluttertoast.showToast(
            msg: "Submitted successfully, check email for giftcards");
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'Please fill all fields');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error uploading details, try again");
      setState(() {
        _isLoading = false;
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
    fetchdollarprice();
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
    final user_details = Provider.of<UserState>(context, listen: false).user;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Sell ${widget.giftcard_name} Gift Card",
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
            child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.image_url,
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
                    Text(
                        dollar_to_naira != null
                            ? 'NGN$dollar_to_naira/dollar'
                            : ".../dollar",
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
                          child: Text(
                              '\$$value - NGN ${dollar_to_naira != null ? dollar_to_naira * value : '...'}'),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        setState(
                          () {
                            _amountTextController.text = value.toString();
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
                            selectedFile != null
                                ? '${selectedFileName.toString()}'
                                : 'Giftcard Document',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Icon(Icons.attach_file),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(selectedFile != null
                    ? selectedFileName.toString()
                    : 'No file selected'),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    if (!_isLoading) {
                      _submit(user_details);
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: sgtheme.cutomDarkColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: !_isLoading
                            ? Text(
                                "Sell ${widget.giftcard_name} Gift Cards ",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            : CircularProgressIndicator.adaptive(),
                      )),
                )
              ],
            ),
          ),
        )));
  }
}
