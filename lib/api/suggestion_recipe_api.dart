import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiSuggestionRecipes {
  static ApiSuggestionRecipes instance = ApiSuggestionRecipes();

  Future<List<dynamic>> searchSuggestionRecipe(String minCal, String maxCal) {
    return api.get(
        "/recipes/findByNutrients?apiKey=0dd4eb84a40745b9a88fcf7361d5683d&minCalories=$minCal&maxCalories=$maxCal&number=10");
  }

  Future<List<dynamic>> allSuggestionRecipe(String minCal, String maxCal) {
    return api.get(
        "/recipes/findByNutrients?apiKey=0dd4eb84a40745b9a88fcf7361d5683d&minCalories=$minCal&maxCalories=$maxCal&number=20");
  }
}

class api {
  static final String baseUrl = "https://api.spoonacular.com";
  static Future<List<dynamic>> get(String partUrl) async {
    final String fullUrl = baseUrl + "/" + partUrl;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");
    final response = await http.get(Uri.parse(fullUrl));
    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponse(response);
  }

  static Future<List<dynamic>> _processResponse(http.Response response) async {
    if (response.statusCode == 200) {
      final body = response.body;
      if (body.isNotEmpty) {
        final jsonBody = json.decode(body);
        return jsonBody;
      } else {
        print("Response body is empty");
        return [];
      }
    } else {
      print("HTTP error: ${response.statusCode}");
      return [];
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}
