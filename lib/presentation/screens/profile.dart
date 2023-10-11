import 'package:flutter/material.dart';
import '../../utils/mode.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sgpaypoint/data/state/user.dart';
import 'package:provider/provider.dart';
import 'package:sgpaypoint/presentation/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgpaypoint/services/api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AllTheme sgtheme = AllTheme();
  final userNameTextEditingController = TextEditingController();
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final bankTextEditingController = TextEditingController();
  Services api = Services();

  _submit() {
// https://sgpaypoint.com.ng/api/updateuser.php?username=nuel123&name=FM Nuel&bank=Access&acctno=0123456789&acctname=Femi Emmanuel
  }
  Future<void> showUserNameDialogAlert(BuildContext context, String username) {
    final details = Provider.of<UserState>(context, listen: false).user;

    userNameTextEditingController.text = username;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update UserName"),
            content: SingleChildScrollView(
              child: Column(children: [
                TextFormField(
                  controller: userNameTextEditingController,
                )
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel", style: TextStyle(color: Colors.red))),
              TextButton(
                  onPressed: () async {
                    var new_username =
                        userNameTextEditingController.text.trim();
                    var response = await api.Post(
                        // "https://sgpaypoint.com.ng/api/updateuser.php?username=$new_username",
                        "https://sgpaypoint.com.ng/api/updateuser.php?username=$new_username&name=${details!.name}&bank=${details!.bank}&acctno=${details.acctno}&acctname=${details!.acctname}",
                        {});

                    Fluttertoast.showToast(msg: 'successfully updated');
                    Navigator.pop(context);
                  },
                  child: Text("OK", style: TextStyle(color: Colors.black))),
            ],
          );
        });
  }

  Future<void> showNameDialogAlert(BuildContext context, String username) {
    final details = Provider.of<UserState>(context, listen: false).user;

    print(details!.acctname);

    userNameTextEditingController.text = username;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update Name"),
            content: SingleChildScrollView(
              child: Column(children: [
                TextFormField(
                  controller: userNameTextEditingController,
                )
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel", style: TextStyle(color: Colors.red))),
              TextButton(
                  onPressed: () async {
                    var new_name = userNameTextEditingController.text.trim();
                    var response = await api.Post(
                        // "https://sgpaypoint.com.ng/api/updateuser.php?username=$new_username",
                        "https://sgpaypoint.com.ng/api/updateuser.php?username=${details!.username}&name=${new_name}&bank=${details!.bank}&acctno=${details.acctno}&acctname=${details!.acctname}",
                        {});

                    Fluttertoast.showToast(msg: 'successfully updated');
                    Navigator.pop(context);
                  },
                  child: Text("OK", style: TextStyle(color: Colors.black))),
            ],
          );
        });
  }

  Future<void> showBankDialogAlert(
      BuildContext context, String bank, String acct_name, String acct_no) {
    final details = Provider.of<UserState>(context, listen: false).user;

    final TextEditingController accountNameTextEditingController =
        TextEditingController();
    final TextEditingController accountNumberTextEditingController =
        TextEditingController();
    final TextEditingController bankNameTextEditingController =
        TextEditingController();

    accountNameTextEditingController.text = acct_name;
    accountNumberTextEditingController.text = acct_no;
    bankNameTextEditingController.text = bank;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Bank Information"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: accountNameTextEditingController,
                  decoration: InputDecoration(labelText: "Account Name"),
                ),
                TextFormField(
                  controller: accountNumberTextEditingController,
                  decoration: InputDecoration(labelText: "Account Number"),
                ),
                TextFormField(
                  controller: bankNameTextEditingController,
                  decoration: InputDecoration(labelText: "Bank Name"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () async {
                var new_name = userNameTextEditingController.text.trim();
                var newAccountName =
                    accountNameTextEditingController.text.trim();
                var newAccountNumber =
                    accountNumberTextEditingController.text.trim();
                var newBankName = bankNameTextEditingController.text.trim();

                var response = await api.Post(
                  "https://sgpaypoint.com.ng/api/updateuser.php?username=${details!.username}&name=${new_name}&bank=${newBankName}&acctno=${newAccountNumber}&acctname=${newAccountName}",
                  {},
                );

                Fluttertoast.showToast(msg: 'Successfully updated');
                Navigator.pop(context);
              },
              child: Text("OK", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  Future<void> showPasswordDialogAlert(BuildContext context) {
    final details = Provider.of<UserState>(context, listen: false).user;
    final TextEditingController passwordTextEditingController =
        TextEditingController();
    bool isPasswordVisible = false;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Password"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: passwordTextEditingController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () async {
                var newUsername = userNameTextEditingController.text.trim();
                var newPassword = passwordTextEditingController.text.trim();
                var response = await api.Post(
                  "https://sgpaypoint.com.ng/api/updateuser.php?username=${details!.username}&name=${newUsername}&bank=${details!.bank}&acctno=${details.acctno}&acctname=${details!.acctname}&password=${newPassword}",
                  {},
                );

                Fluttertoast.showToast(msg: 'Successfully updated');
                Navigator.pop(context);
              },
              child: Text("OK", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    double screen_width = MediaQuery.of(context).size.width;
    final user_details = Provider.of<UserState>(context, listen: false);

    return Scaffold(
        backgroundColor: darkMode ? sgtheme.blackHomeColor : Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: screen_width,
                padding: EdgeInsets.only(top: 40, bottom: 40),
                // margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    color: sgtheme.blackColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: sgtheme
                          .blackHomeColor, // Change the background color as needed
                      radius: 30,
                      child: Text(
                        "M",
                        style: TextStyle(
                          color:
                              Colors.white, // Change the text color as needed
                          fontSize: 20, // Adjust the text size as needed
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Moses",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text("benmos16@gmail.com",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Text(
                      "Mosboy",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SETTINGS",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        iconColor: darkMode ? Colors.white : Colors.black,
                        leading: Icon(FontAwesomeIcons.user,
                            color: darkMode ? Colors.white : Colors.black),
                        title: Text(
                          'Username',
                          style: TextStyle(
                              color: darkMode ? Colors.white : Colors.black),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 15),
                        onTap: () {
                          showUserNameDialogAlert(
                              context, user_details!.user!.username);
                        },
                      ),
                      // Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        iconColor: darkMode ? Colors.white : Colors.black,
                        leading: Icon(FontAwesomeIcons.userCheck,
                            color: darkMode ? Colors.white : Colors.black),
                        title: Text(
                          'Name',
                          style: TextStyle(
                              color: darkMode ? Colors.white : Colors.black),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 15),
                        onTap: () {
                          showNameDialogAlert(
                              context, user_details!.user!.name);
                        },
                      ),
                      // Divider(),
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          iconColor: darkMode ? Colors.white : Colors.black,
                          leading: Icon(Icons.mail_lock,
                              color: darkMode ? Colors.white : Colors.black),
                          title: Text(
                            'Email Address',
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black),
                          ),
                          trailing: Icon(Icons.lock, size: 15),
                          onTap: null),
                      // Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        iconColor: darkMode ? Colors.white : Colors.black,
                        leading: Icon(FontAwesomeIcons.bank,
                            color: darkMode ? Colors.white : Colors.black),
                        title: Text(
                          'Bank',
                          style: TextStyle(
                              color: darkMode ? Colors.white : Colors.black),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 15),
                        onTap: () {
                          showBankDialogAlert(
                              context,
                              user_details.user!.bank!,
                              user_details.user!.acctname!,
                              user_details.user!.acctno!);
                        },
                      ),
                      // Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        iconColor: darkMode ? Colors.white : Colors.black,
                        leading: Icon(FontAwesomeIcons.lock,
                            color: darkMode ? Colors.white : Colors.black),
                        title: Text(
                          'Change Password',
                          style: TextStyle(
                              color: darkMode ? Colors.white : Colors.black),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 15),
                        onTap: () {
                          showPasswordDialogAlert(context);
                        },
                      ),
                      SizedBox(height: 30),
                      Text(
                        "SOCIAL HANDLES",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 10),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        iconColor: darkMode ? Colors.white : Colors.black,
                        leading: Icon(FontAwesomeIcons.instagram,
                            color: darkMode ? Colors.white : Colors.black),
                        title: Text(
                          'Follow on Instagram',
                          style: TextStyle(
                              color: darkMode ? Colors.white : Colors.black),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 15),
                        onTap: () {
                          // Navigator.pushNamed(context, AppRoutes.trade_giftcard);
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        iconColor: darkMode ? Colors.white : Colors.black,
                        leading: Icon(FontAwesomeIcons.twitter,
                            color: darkMode ? Colors.white : Colors.black),
                        title: Text(
                          'Follow on Twitter',
                          style: TextStyle(
                              color: darkMode ? Colors.white : Colors.black),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 15),
                        onTap: () {
                          // Navigator.pushNamed(context, AppRoutes.trade_giftcard);
                        },
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          iconColor: darkMode ? Colors.white : Colors.black,
                          leading: Icon(FontAwesomeIcons.facebook,
                              color: darkMode ? Colors.white : Colors.black),
                          title: Text(
                            'Follow On Facebook',
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, size: 15),
                          onTap: () {
                            // Navigator.pushNamed(context, AppRoutes.trade_giftcard);
                          }),
                      SizedBox(height: 30),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        iconColor: darkMode ? Colors.white : Colors.black,
                        leading: Icon(FontAwesomeIcons.signOut,
                            color: darkMode
                                ? sgtheme.cutomDarkColor
                                : sgtheme.customColor),
                        title: Text(
                          'Sign Out',
                          style: TextStyle(
                              color: darkMode
                                  ? sgtheme.cutomDarkColor
                                  : sgtheme.customColor),
                        ),
                        // trailing: Icon(Icons.arrow_forward_ios, size: 15),
                        onTap: () {
                          user_details.clearUserData();
                          Navigator.pushNamed(context, AppRoutes.signin);
                        },
                      ),
                    ],
                  ))
            ]),
          ),
        ));
  }
}
