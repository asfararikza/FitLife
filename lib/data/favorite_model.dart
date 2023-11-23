class FavoriteRecipe {
  final int id;
  final String emailUser;
  final String recipeId;
  final String image;
  final String title;
  final String readyInMinutes;
  final String servings;
  final String calories;

  FavoriteRecipe({
    required this.id,
    required this.emailUser,
    required this.recipeId,
    required this.image,
    required this.title,
    required this.readyInMinutes,
    required this.servings,
    required this.calories,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'emailUser': emailUser,
      'recipeId': recipeId,
      'image': image,
      'title': title,
      'readyInMinutes': readyInMinutes,
      'servings': servings,
      'calories': calories,
    };
  }

  factory FavoriteRecipe.fromMap(Map<String, dynamic> map) {
    return FavoriteRecipe(
      id: map['id'],
      emailUser: map['emailUser'],
      recipeId: map['recipeId'],
      image: map['image'],
      title: map['title'],
      readyInMinutes: map['readyInMinutes'],
      servings: map['servings'],
      calories: map['calories'],
    );
  }
}
