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
import 'package:sgpaypoint/data/models/user.dart';
import 'package:sgpaypoint/data/state/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final storage = FlutterSecureStorage();
  var logger = Logger();
  final AllTheme sgtheme = AllTheme();
  bool _isPasswordVisible = false;
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isChecked = false; // State variable to track the checkbox state
  bool _isFocused = false;
  bool _isloading = false;

  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  Services api = Services();

  //declare a Global key
  final _formkey = GlobalKey<FormState>();

  void _submit() async {
    setState(() {
      _isloading = true;
    });

    try {
      if (_formkey.currentState!.validate()) {
        Map<String, dynamic> userMap = {
          "username": _usernameTextController.text.trim(),
          "password": _passwordTextController.text.trim(),
        };

        var response = await api.Post(
            "$endpoint/login.php?username=${userMap["username"]}&password=${userMap["password"]}",
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

          Fluttertoast.showToast(msg: "You are successfully Signed In");
          Navigator.pushNamed(context, AppRoutes.main);
        }
      } else {
        setState(() {
          _isloading = false;
        });
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Unable to Sign In, try again!");
      setState(() {
        _isloading = false;
      });
    }
  }

  // Function to handle focus change
  void _onFocusChange() {
    setState(() {
      // Update the _isFocused state based on the focus state of any text field
      _isFocused = _usernameFocusNode.hasFocus || _passwordFocusNode.hasFocus;
    });
  }

  void initState() {
    super.initState();
    // Add listener to _usernameFocusNode and _passwordFocusNode
    _usernameFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _usernameFocusNode.removeListener(_onFocusChange);
    _passwordFocusNode.removeListener(_onFocusChange);
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  List<Widget> _buildChildren() {
    return [
      Form(
        key: _formkey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign In",
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
                )),
                child: TextFormField(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text("Forget Password ?",
                        style: TextStyle(color: sgtheme.customColor)),
                  )
                ],
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: !_isloading ? _submit : null,
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
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          : CircularProgressIndicator(
                              backgroundColor: sgtheme.customColor),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.signup);
                    },
                    child: Text(
                      " Create Account",
                      style: TextStyle(
                          color: sgtheme.customColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ]),
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
                      children: _buildChildren(),
                    ),
                  ),
                ),
              ),
            )),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              top: _isFocused ? -150 : 0,
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
              top: _isFocused ? -160 : -10,
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
              top: _isFocused ? -100 : -10,
              child: Image.asset(
                "public/images/ellipse-39.png",
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              top: _isFocused ? 30 : 80,
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
