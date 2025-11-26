import 'package:flutter/material.dart';
import 'package:lab2/models/meal_model.dart';
import 'package:lab2/services/api_service.dart';

class MealDetailPage extends StatefulWidget {
  const MealDetailPage({super.key});

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  final ApiService _apiService = ApiService();

  late String _mealId;
  Meal? _meal;
  bool _loading = true;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)!.settings.arguments;
      _mealId = args as String;
      _loadMeal();
      _initialized = true;
    }
  }

  Future<void> _loadMeal() async {
    final meal = await _apiService.loadMealById(_mealId);
    setState(() {
      _meal = meal;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _meal == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final meal = _meal!;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  meal.thumbnailUrl,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              meal.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8,),
            const Text(
              'Инструкции:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              meal.instructions,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Состојки:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...meal.ingredients.entries.map(
                  (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text('• ${entry.key} - ${entry.value}'),
              ),
            ),
            const SizedBox(height: 16),
            if (meal.youtubeUrl.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.video_camera_front_outlined),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      meal.youtubeUrl,
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
