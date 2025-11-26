import 'package:flutter/material.dart';
import 'package:lab2/screens/HomePage.dart';
import 'package:lab2/screens/detailpage.dart';
import 'package:lab2/screens/mealspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan.shade50),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(title: 'Рецепти - 226013'),
        "/meals": (context) => const MealsPage(),
        "/mealDetails": (context) => const MealDetailPage(),
      },
    );
  }
}

