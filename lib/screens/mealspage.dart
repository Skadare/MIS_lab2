import 'package:flutter/material.dart';
import 'package:lab2/models/category_model.dart';
import 'package:lab2/models/meal_summary_model.dart';
import 'package:lab2/services/api_service.dart';
import 'package:lab2/widgets/meals_grid.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPage();
}

class _MealsPage extends State<MealsPage>{
  final ApiService _apiService = ApiService();

  late Category _category;
  List<MealSummary> _meals = [];
  List<MealSummary> _filteredMeals = [];
  bool _loading = true;
  String _searchQuery = '';
  bool _initialized = false;
  final TextEditingController _searchController = TextEditingController();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)!.settings.arguments;
      _category = args as Category;
      _loadMeals();
      _initialized = true;
    }
  }

  Future<void> _loadMeals() async {
    final meals = await _apiService.loadMealsByCategory(_category.name);
    setState(() {
      _meals = meals;
      _filteredMeals = meals;
      _loading = false;
    });
  }

  void _filterMeals(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredMeals = _meals;
      } else {
        final lower = query.toLowerCase();
        _filteredMeals = _meals
            .where((m) => m.name.toLowerCase().contains(lower))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_category.name),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Пребарај јадења...',
                border: OutlineInputBorder(),
              ),
              onChanged: _filterMeals,
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : MealsGrid(
              meals: _filteredMeals,
              onMealTap: (meal) {
                 Navigator.pushNamed(context, '/mealDetails', arguments: meal.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}