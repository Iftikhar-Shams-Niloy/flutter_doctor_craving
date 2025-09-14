import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_doctor_craving/models/food.dart';
import 'package:flutter_doctor_craving/screens/filters_screen.dart';
import 'package:flutter_doctor_craving/screens/food_categories_screen.dart';
import 'package:flutter_doctor_craving/screens/foods_screen.dart';
import 'package:flutter_doctor_craving/widgets/main_drawer.dart';
import 'package:flutter_doctor_craving/provider/food_provider.dart';

Map<Filter, bool> kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Food> _favoriteFoods = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleFoodFavoriteStatus(Food food) {
    final isExisting = _favoriteFoods.contains(food);
    if (isExisting) {
      setState(() {
        _favoriteFoods.remove(food);
      });
      _showInfoMessage("Removed from Favorites!");
    } else {
      setState(() {
        _favoriteFoods.add(food);
      });
      _showInfoMessage("Added to Favorites!");
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result =
          await Navigator.of(
            context,
          ).push<Map<Filter, bool>>(
            MaterialPageRoute(
              builder: (ctx) => FiltersScreen(
                currentFilters: _selectedFilters,
              ),
            ),
          );
      _selectedFilters = result ?? kInitialFilters;
    }
  }

  @override
  Widget build(BuildContext context) {
    final foods = ref.watch(foodsProvider);
    final availableFoods = foods.where((food) {
      if (_selectedFilters[Filter.glutenFree]! && !food.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !food.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !food.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.glutenFree]! && !food.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = FoodCategoriesScreen(
      onToggleFavorite: _toggleFoodFavoriteStatus,
      availableFoods: availableFoods,
    );
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      activePage = FoodsScreen(
        foods: _favoriteFoods,
        onToggleFavorite: _toggleFoodFavoriteStatus,
      );
      activePageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
