class MealSummary{
  final String id;
  final String name;
  final String thumbnailUrl;

  MealSummary({required this.id, required this.name, required this.thumbnailUrl});

  factory MealSummary.fromJson(Map<String, dynamic> json){
    return MealSummary(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnailUrl: json['strMealThumb']
    );
  }
}