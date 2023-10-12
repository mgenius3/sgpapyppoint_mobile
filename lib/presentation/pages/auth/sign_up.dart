import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../../theme/main_theme.dart';
import '../../routes.dart';
import 'package:logger/logger.dart';
import 'package:sgpaypoint/services/api_service.dart';
import 'package:sgpaypoint/data/global/constant.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgpaypoint/utils/helpers.dart';
import 'package:sgpaypoint/data/state/user.dart';
import 'package:sgpaypoint/data/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final storage = FlutterSecureStorage();
  Services api = Services();
  var logger = Logger();
  final AllTheme sgtheme = AllTheme();
  bool _isPasswordVisible = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();

  bool _isFocused = false;
  bool _isloading = false;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _phoneNumberTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  //declare a Global key
  final _formkey = GlobalKey<FormState>();

  void _submit(BuildContext context) async {
    try {
      if (_formkey.currentState!.validate()) {
        setState(() {
          _isloading = true;
        });
        Map<String, dynamic> userMap = {
          "username": _usernameTextController.text.trim(),
          "name": _nameTextController.text.trim(),
          "email": _emailTextController.text.trim(),
          "password": _passwordTextController.text.trim(),
          "cpassword": _confirmPasswordTextController.text.trim(),
          "phone": _phoneNumberTextController.text.trim(),
        };

        var response = await api.Post(
            "$endpoint/register.php?username=${userMap["username"]}&password=${userMap["password"]}&cpassword=${userMap["cpassword"]}&email=${userMap["email"]}&name=${userMap["name"]}",
            {});

        String errorMessage = refactor_response_obj(response)['error'];

        if (errorMessage.isNotEmpty) {
          setState(() {
            _isloading = false;
          });

          Fluttertoast.showToast(msg: errorMessage);
        } else {
          var response =
              await api.Get("$endpoint/users.php?user=${userMap["username"]}");
          //sending data to state management
          Provider.of<UserState>(context, listen: false)
              .updateUserDetails(response);
          await storage.write(key: 'sign', value: 'true');
          Fluttertoast.showToast(msg: "You are successfully registered");
          Navigator.pushNamed(context, AppRoutes.main);
        }
      } else {
        setState(() {
          _isloading = false;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Unable to Sign Up, try again!");
      setState(() {
        _isloading = false;
      });
    }
  }

  // Function to handle focus change
  void _onFocusChange() {
    setState(() {
      // Update the _isFocused state based on the focus state of any text field
      _isFocused = _emailFocusNode.hasFocus ||
          _passwordFocusNode.hasFocus ||
          _confirmFocusNode.hasFocus ||
          _phoneFocusNode.hasFocus ||
          _nameFocusNode.hasFocus ||
          _usernameFocusNode.hasFocus;
    });
  }

  void initState() {
    super.initState();
    // Add listener to _emailFocusNode and _passwordFocusNode
    _emailFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
    _confirmFocusNode.addListener(_onFocusChange);
    _nameFocusNode.addListener(_onFocusChange);
    _phoneFocusNode.addListener(_onFocusChange);
    _usernameFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_onFocusChange);
    _passwordFocusNode.removeListener(_onFocusChange);
    _nameFocusNode.removeListener(_onFocusChange);
    _phoneFocusNode.removeListener(_onFocusChange);
    _confirmFocusNode.removeListener(_onFocusChange);
    _usernameFocusNode.removeListener(_onFocusChange);

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _usernameFocusNode.dispose();

    super.dispose();
  }

  List<Widget> _buildChildren(BuildContext context) {
    return [
      Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(height: 16.0),
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
                focusNode: _usernameFocusNode,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border:
                      OutlineInputBorder(), // Set the border to a rectangular shape
                  focusColor: sgtheme.customColor,
                  prefixIcon: Icon(
                    Icons.person,
                    color: _usernameFocusNode.hasFocus
                        ? sgtheme.customColor
                        : Colors.black,
                  ),
                  hintText: 'Mosboy',
                  labelStyle: TextStyle(
                    color: _usernameFocusNode.hasFocus
                        ? sgtheme.customColor
                        : Colors.black,
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'username can\'t be empty';
                  }

                  if (text.length < 2) {
                    return "Please enter a valid name";
                  }
                  if (text.length > 99) {
                    return 'username can\t be more than 50';
                  }
                },
                onChanged: (text) => setState(() {
                  _usernameTextController.text = text;
                }),
              ),
            ),
            SizedBox(height: 16.0),

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
                cursorColor: sgtheme.blackHomeColor,
                focusNode: _nameFocusNode,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border:
                      OutlineInputBorder(), // Set the border to a rectangular shape
                  focusColor: sgtheme.customColor,
                  prefixIcon: Icon(
                    Icons.person,
                    color: _nameFocusNode.hasFocus
                        ? sgtheme.customColor
                        : Colors.black,
                  ),
                  hintText: 'Moses Osewe Benjamin',
                  labelStyle: TextStyle(
                    color: _nameFocusNode.hasFocus
                        ? sgtheme.customColor
                        : Colors.black,
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Full Name can\'t be empty';
                  }

                  if (text.length < 2) {
                    return "Please enter a valid name";
                  }
                  if (text.length > 99) {
                    return 'Full Name can\t be more than 50';
                  }
                },
                onChanged: (text) => setState(() {
                  _nameTextController.text = text;
                }),
              ),
            ),
            SizedBox(height: 16.0),
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
                cursorColor: sgtheme.blackHomeColor,
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border:
                      OutlineInputBorder(), // Set the border to a rectangular shape
                  focusColor: sgtheme.customColor,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: _emailFocusNode.hasFocus
                        ? sgtheme.customColor
                        : Colors.black,
                  ),
                  hintText: 'sam@gmail.com',
                  labelStyle: TextStyle(
                    color: _emailFocusNode.hasFocus
                        ? sgtheme.customColor
                        : Colors.black,
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Email can\'t be empty';
                  }
                  if (EmailValidator.validate(text) == true) {
                    return null;
                  }
                  if (text.length < 2) {
                    return "Please enter a valid email";
                  }
                  if (text.length > 99) {
                    return 'Email can\t be more than 50';
                  }
                },
                onChanged: (text) => setState(() {
                  _emailTextController.text = text;
                }),
              ),
            ),
            SizedBox(height: 16.0),
            // Theme(
            //     data: ThemeData(
            //         inputDecorationTheme: InputDecorationTheme(
            //       floatingLabelBehavior: FloatingLabelBehavior.always,
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: sgtheme.customColor),
            //       ),
            //     )),
            //     child: TextFormField(
            //       controller: _phoneNumberTextController,
            //       keyboardType: TextInputType.phone,
            //       decoration: InputDecoration(
            //         labelText: 'Phone Number',
            //         hintText: 'Enter your phone number',
            //         prefixIcon: Icon(
            //           Icons.phone,
            //           color: _phoneFocusNode.hasFocus
            //               ? sgtheme.customColor
            //               : Colors.black,
            //         ),
            //         border: OutlineInputBorder(),
            //         labelStyle: TextStyle(
            //           color: _phoneFocusNode.hasFocus
            //               ? sgtheme.customColor
            //               : Colors.black,
            //         ),
            //       ),
            //       validator: (value) {
            //         // You can add validation here if needed.
            //         // For example, check if the input is a valid phone number.
            //         if (value == null || value.isEmpty) {
            //           return 'Please enter your phone number';
            //         }
            //         // You can use regular expressions or other methods to validate the phone number.
            //         // For a basic example, let's check if it contains at least 10 digits.
            //         if (value.length < 10) {
            //           return 'Please enter a valid phone number';
            //         }
            //         return null; // Return null to indicate the input is valid.
            //       },
            //     )),
            // SizedBox(height: 16.0),
            Theme(
              data: ThemeData(
                  inputDecorationTheme: InputDecorationTheme(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: sgtheme.customColor),
                ),
              )),
              child: TextFormField(
                cursorColor: sgtheme.blackHomeColor,
                focusNode: _passwordFocusNode,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: _passwordFocusNode.hasFocus
                        ? sgtheme.customColor
                        : Colors.black,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: _passwordFocusNode.hasFocus
                          ? sgtheme.customColor
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border:
                      OutlineInputBorder(), // Set the border to a rectangular shape
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Password can\'t be empty';
                  }
                  if (text.length < 6) {
                    return "Password can not be less than 6";
                  }
                  if (text.length > 25) {
                    return 'Password can\'t be more than 25';
                  }
                },
                onChanged: (text) =>
                    setState(() => {_passwordTextController.text = text}),
              ),
            ),
            SizedBox(height: 15.0),
            Theme(
              data: ThemeData(
                  inputDecorationTheme: InputDecorationTheme(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: sgtheme.customColor),
                ),
              )),
              child: TextFormField(
                cursorColor: sgtheme.blackHomeColor,
                focusNode: _confirmFocusNode,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(
                    color: _confirmFocusNode.hasFocus
                        ? sgtheme.customColor
                        : Colors.black,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: _confirmFocusNode.hasFocus
                          ? sgtheme.customColor
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border:
                      OutlineInputBorder(), // Set the border to a rectangular shape
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Confirm Password can\'t be empty';
                  }
                  if (text != _passwordTextController.text) {
                    return "Confirm Password do not match";
                  }
                  if (text.length < 6) {
                    return "Please enter a valid confirm password";
                  }
                  if (text.length > 25) {
                    return 'Confirm Password can\'t be more than 25';
                  }
                },
                onChanged: (text) => setState(
                    () => {_confirmPasswordTextController.text = text}),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                if (!_isloading) {
                  _submit(context);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: sgtheme.blackColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Center(
                    child: !_isloading
                        ? Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        : CircularProgressIndicator(
                            backgroundColor: sgtheme.cutomDarkColor,
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account ? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.signin);
                  },
                  child: Text(
                    "  Sign In",
                    style: TextStyle(
                        color: sgtheme.customColor,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: () {
          // Unfocus the text fields when tapping outside of them
          FocusScope.of(context).unfocus();
          // Update _isFocused state to false when tapping outside of the text fields
          setState(() {
            _isFocused = false;
          });
        },
        child: Scaffold(
          body: Stack(children: [
            Positioned(
                child: Container(
              margin: EdgeInsets.only(top: 200),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildChildren(context),
                    ),
                  ),
                ),
              ),
            )),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              top: _isFocused ? -150 : -90,
              left: -38,
              child: Image.asset(
                "public/images/ellipse-40.png",
                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              left: -20,
              top: _isFocused ? -160 : -100,
              child: Image.asset(
                "public/images/ellipse-37.png",
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.4,
                // fit: BoxFit.cover,
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              right: 0,
              top: _isFocused ? -100 : -70,
              child: Image.asset(
                "public/images/ellipse-39.png",
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              top: _isFocused ? 30 : 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 2, left: 2),
                    child: Image.asset(
                      "public/images/sg_platform.png",
                      width: screen_width * 0.3,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                        color: Colors.white, fontSize: screen_width * 0.04),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )
          ]),
        ));
  }
}
