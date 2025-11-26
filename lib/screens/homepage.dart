import 'package:lab2/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:lab2/services/api_service.dart';
import 'package:lab2/widgets/list_category.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState()=>_HomePage();
}

class _HomePage extends State<HomePage>{
  final ApiService _apiService = ApiService();
  List<Category> _categories = [];
  List<Category> _filteredCategories = [];
  bool _loading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async{
    final categories = await _apiService.loadCategories();
    setState(() {
      _categories = categories;
      _filteredCategories  = categories;
      _loading = false;
    });
  }

  void _filterCategories(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        final lower = query.toLowerCase();
        _filteredCategories = _categories
            .where((c) => c.name.toLowerCase().contains(lower))
            .toList();
      }
    });
  }


  Future<void> _openRandomMeal() async {
    final randomMeal = await _apiService.loadRandomMeal();

    if (randomMeal == null) return;
    Navigator.pushNamed(context,'/mealDetails',arguments: randomMeal.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
              tooltip: 'Рандом рецепт на денот',
              icon: const Icon(Icons.shuffle),
              onPressed: _openRandomMeal,
            ),
          ],
        ),
        body:
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Пребарај категории...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: _filterCategories,
              ),
            ),
            Expanded(
              child: CategoryList(categories: _filteredCategories),
            ),
          ],
        )
    );
  }


}