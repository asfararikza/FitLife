import 'base_network.dart';

class ApiRandomRecipes {
  static ApiRandomRecipes instance = ApiRandomRecipes();
  Future<Map<String, dynamic>> loadRandomRecipes() {
    return BaseNetwork.get(
        "recipes/random?apiKey=0dd4eb84a40745b9a88fcf7361d5683d&number=5");
  }

  Future<Map<String, dynamic>> categoryRecipes(String categoryName) {
    String category = categoryName.toString();
    return BaseNetwork.get(
        "recipes/random?apiKey=0dd4eb84a40745b9a88fcf7361d5683d&number=10&tags=$category");
  }

  Future<Map<String, dynamic>> informationRecipe(String idRecipe) {
    String id = idRecipe.toString();
    return BaseNetwork.get(
        "/recipes/$id/information?apiKey=0dd4eb84a40745b9a88fcf7361d5683d&includeNutrition=true");
  }

  Future<Map<String, dynamic>> searchRecipe(String query) {
    return BaseNetwork.get(
        "/recipes/complexSearch?apiKey=0dd4eb84a40745b9a88fcf7361d5683d&query=$query&number=10&sort=popularity");
  }
}
