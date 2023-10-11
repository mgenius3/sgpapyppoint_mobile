import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

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
