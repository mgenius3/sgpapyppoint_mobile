import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_database/firebase_database.dart';

refactor_response_obj(response) {
  return jsonDecode(jsonEncode(response));
}

final String whatsappUrl = "https://wa.me/+2348134460259";

// Function to open WhatsApp
void openWhatsApp() async {
  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
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
