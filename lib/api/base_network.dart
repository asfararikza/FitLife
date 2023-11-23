import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseNetwork {
  static final String baseUrl = "https://api.spoonacular.com";
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
