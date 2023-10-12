import 'package:flutter/material.dart';
import 'package:sgpaypoint/presentation/theme/app_theme.dart';
import 'package:sgpaypoint/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:sgpaypoint/data/state/user.dart';
import 'package:sgpaypoint/presentation/theme/main_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WithdrawalPage extends StatefulWidget {
  @override
  _WithdrawalPageState createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  AllTheme sgtheme = AllTheme();

  final TextEditingController amountController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  bool _isloading = false;
  String selectedWallet = 'Naira Wallet'; // Default selected wallet
  Services api = Services();

  var theme_data = ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.red, // Set your desired cursor color here
      selectionHandleColor:
          Colors.blue, // Optional: Change the selection handle color
      selectionColor: Colors.grey, // Optional: Change the selection color
    ),
  );

  _submit(username) {
    try {
      if (amountController.text.isNotEmpty) {
        final withdrawalAmount = amountController.text;

        setState(() {
          _isloading = true;
        });

        late String wallet;

        if (selectedWallet == "Naira Wallet")
          wallet = "naira";
        else
          wallet = "bonus";

        var response = api.Post(
            'https://sgpaypoint.com.ng/api/withdraw.php?username=${username}&amount=${withdrawalAmount}&wallet=$wallet',
            {});

        // Show a confirmation dialog or navigate to a success page
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Withdrawal Request Submitted'),
              content: Text(
                  'Your withdrawal request has been received from $selectedWallet.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK', style: TextStyle(color: Colors.green)),
                ),
              ],
            );
          },
        );
        setState(() {
          _isloading = false;
        });
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
      amountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final details = Provider.of<UserState>(context, listen: false).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Withdrawal Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: selectedWallet,
              onChanged: (String? newValue) {
                setState(() {
                  selectedWallet = newValue!;
                });
              },
              items: <String>['Naira Wallet', 'Bonus Wallet']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Withdrawal Amount'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: accountNameController,
              readOnly: true,
              decoration: InputDecoration(
                  labelText:
                      '${details!.acctname!.isEmpty ? "No account name" : details!.acctname}'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: accountNumberController,
              readOnly: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText:
                    '${details!.acctno!.isEmpty ? "No account number" : details!.acctno}',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: bankNameController,
              decoration: InputDecoration(
                  labelText:
                      '${details!.bank!.isEmpty ? "No bank" : details!.bank}',
                  hintText: 'bank'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    // Color when the button is pressed
                    return sgtheme.blackHomeColor;
                  } else if (states.contains(MaterialState.disabled)) {
                    // Color when the button is disabled
                    return sgtheme.buttonInactiveColor;
                  }
                  // Default color
                  return sgtheme.cutomDarkColor;
                }),
              ),
              onPressed: () {
                _submit(details.username);
              },
              child: Text(
                'Submit Withdrawal Request',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
