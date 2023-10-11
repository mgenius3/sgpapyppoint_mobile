import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class UserState extends ChangeNotifier {
  User? user;

  void updateUserDetails(user_data) {
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

    notifyListeners();
  }

  void clearUserData() {
    user = null;
    notifyListeners();
  }
}
