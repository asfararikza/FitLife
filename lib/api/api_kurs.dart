import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiMoneCurrency {
  static ApiMoneCurrency instance = ApiMoneCurrency();

  Future<Map<String, dynamic>> getCurrency() {
    return apiCurrency
        .get("latest?apikey=05ec50bbf7004f10a79fa0de4d9806ce&format=json");
  }
}

class apiCurrency {
  static final String baseUrl = "https://api.currencyfreaks.com";
  static Future<Map<String, dynamic>> get(String partUrl) async {
    final String fullUrl = baseUrl + "/" + partUrl;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");
    final response = await http.get(Uri.parse(fullUrl));
    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(
      http.Response response) async {
    if (response.statusCode == 200) {
      final body = response.body;
      if (body.isNotEmpty) {
        final jsonBody = json.decode(body);
        return jsonBody;
      } else {
        print("Response body is empty");
        return {"error": true};
      }
    } else {
      print("HTTP error: ${response.statusCode}");
      return {"error": true};
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}
