import 'package:flutter/cupertino.dart';
import '../models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class UserState extends ChangeNotifier {
  User? user;
  final storage = FlutterSecureStorage();

  void updateUserDetails(user_data) async {
    var refactor_user_details = user_data['items'][0];
    user = User(
      username: refactor_user_details["Username"] ?? "",
      email: refactor_user_details["Email"] ?? "",
      name: refactor_user_details["Name"] ?? "",
      naira_Wallet_Balance: refactor_user_details["Naira Wallet Balance"] ?? "",
      bonus_wallet_Balance: refactor_user_details["Bonus Wallet Balance"] ?? "",
      id: refactor_user_details["id"] ?? "",
      bank: refactor_user_details["Bank"] ?? "",
      acctno: refactor_user_details["Account Number"] ?? "",
      acctname: refactor_user_details["Account Name"] ?? "",
    );

    DateTime expiryDate = DateTime.now()
        .add(Duration(hours: 12)); // Example: Data expires in 7 days
    await storage.write(key: 'user_data', value: jsonEncode(user_data));
    await storage.write(key: 'expiryDate', value: expiryDate.toIso8601String());

    notifyListeners();
  }

  void clearUserData() async {
    await storage.delete(key: 'user_data');
    await storage.delete(key: 'expiryDate');
    user = null;
    notifyListeners();
  }
}
