import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

refactor_response_obj(response) {
  return jsonDecode(jsonEncode(response));
}

// Function to open WhatsApp
void openLink(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Could not launch WhatsApp';
  }
}

Future<int> fetchCurrentDollarPrice() async {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child("price");

  int valueToReturn = 0;

  // Use await to wait for the data retrieval
  DatabaseEvent dataSnapshot = await databaseReference.once();

  if (dataSnapshot.snapshot.value != null) {
    Map<dynamic, dynamic> values =
        refactor_response_obj(dataSnapshot.snapshot.value);
    valueToReturn = values['naira_to_dollar'];
  } else {
    valueToReturn = 0;
  }

  return valueToReturn;
}
