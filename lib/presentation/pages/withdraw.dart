import 'package:flutter/material.dart';

class WithdrawalPage extends StatefulWidget {
  @override
  _WithdrawalPageState createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  String selectedWallet = 'Naira Wallet'; // Default selected wallet

  @override
  Widget build(BuildContext context) {
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
              decoration: InputDecoration(labelText: 'Account Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: accountNumberController,
              readOnly: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Account Number'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: bankNameController,
              decoration: InputDecoration(labelText: 'Bank Name'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Process withdrawal request here
                final withdrawalAmount = amountController.text;
                final accountName = accountNameController.text;
                final accountNumber = accountNumberController.text;
                final bankName = bankNameController.text;
                final selectedWalletType =
                    selectedWallet; // Get selected wallet

                // You can now send this data to your backend for processing

                // Optionally, clear the input fields after submission
                amountController.clear();
                accountNameController.clear();
                accountNumberController.clear();
                bankNameController.clear();

                // Show a confirmation dialog or navigate to a success page
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Withdrawal Request Submitted'),
                      content: Text(
                          'Your withdrawal request has been received from $selectedWalletType.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Submit Withdrawal Request'),
            ),
          ],
        ),
      ),
    );
  }
}
