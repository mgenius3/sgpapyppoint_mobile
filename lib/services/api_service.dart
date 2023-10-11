import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class Services {
  Get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode >= 200 && response.statusCode < 400) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  Post(String url, dynamic body, {String token = ""}) async {
    var authHeaders = {"Content-Type": "application/json"};

    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode(body), // Used jsonEncode instead of jsonDecode
          headers: token.isEmpty
              ? authHeaders
              : {...authHeaders, "Authorization": "Bearer $token"});

      print(jsonDecode(response.body));

      if (response.statusCode >= 200 && response.statusCode < 400) {
        return {"error": "", ...jsonDecode(response.body)};
      } else {
        var error_response = jsonDecode(response.body);
        return {"error": error_response["message"]};
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  Future<List<dynamic>> fetchCryptoPriceData(String cryptocurrencyName) async {
    final data = await this.Get(
      'https://api.coincap.io/v2/assets/$cryptocurrencyName/history?interval=d1',
    );
    return (data['data']);
  }
}
