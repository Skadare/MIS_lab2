import 'package:flutter/material.dart';
import 'package:lab2/models/category_model.dart';
import 'package:lab2/widgets/category_card.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;

  const CategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryCard(category: categories[index]);
      },
    );
  }
}
