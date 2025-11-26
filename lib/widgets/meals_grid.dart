import 'package:flutter/material.dart';
import 'package:lab2/models/meal_summary_model.dart';

class MealsGrid extends StatelessWidget {
  final List<MealSummary> meals;
  final void Function(MealSummary meal)? onMealTap;

  const MealsGrid({
    super.key,  required this.meals, this.onMealTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return GestureDetector(
          onTap: () {
            if (onMealTap != null) {
              onMealTap!(meal);
            }
          },
          child: Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    meal.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    meal.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
