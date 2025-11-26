class Meal{
  final String id;
  final String name;
  final String category;
  final String thumbnailUrl;
  final String instructions;
  final String youtubeUrl;
  final Map<String, String> ingredients;

  Meal(
      {required this.id, required this.name, required this.category, required this.thumbnailUrl, required this.instructions,
        required this.youtubeUrl, required this.ingredients});

  factory Meal.fromJson(Map<String, dynamic> json) {
    final Map<String, String> ingredientsMap = {};
    for (int i = 1; i <= 20; i++) {
      final ingredient = (json['strIngredient$i'] );
      final measure = (json['strMeasure$i']);
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredientsMap[ingredient] = measure ?? '';
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      category: json['strCategory'] ?? '',
      thumbnailUrl: json['strMealThumb'] ?? '',
      instructions: json['strInstructions'] ?? '',
      youtubeUrl: json['strYoutube'] ?? '',
      ingredients: ingredientsMap,
    );
  }
}