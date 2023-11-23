class SuggestionRecipesModel {
  int? id;
  String? title;
  String? image;
  String? imageType;
  int? calories;
  String? protein;
  String? fat;
  String? carbs;

  SuggestionRecipesModel({
    this.id,
    this.title,
    this.image,
    this.imageType,
    this.calories,
    this.protein,
    this.fat,
    this.carbs,
  });

  SuggestionRecipesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    image = json['image'] as String?;
    imageType = json['imageType'] as String?;
    calories = json['calories'] as int?;
    protein = json['protein'] as String?;
    fat = json['fat'] as String?;
    carbs = json['carbs'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['title'] = title;
    json['image'] = image;
    json['imageType'] = imageType;
    json['calories'] = calories;
    json['protein'] = protein;
    json['fat'] = fat;
    json['carbs'] = carbs;
    return json;
  }
}
