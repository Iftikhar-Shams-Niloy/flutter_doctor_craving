import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_doctor_craving/screens/filters_screen.dart';
import 'package:flutter_doctor_craving/screens/food_categories_screen.dart';
import 'package:flutter_doctor_craving/screens/foods_screen.dart';
import 'package:flutter_doctor_craving/widgets/main_drawer.dart';
import 'package:flutter_doctor_craving/providers/food_provider.dart';
import 'package:flutter_doctor_craving/providers/favorites_provider.dart';
import 'package:flutter_doctor_craving/providers/filters_provider.dart';

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

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
          await Navigator.of(
            context,
          ).push<Map<Filter, bool>>(
            MaterialPageRoute(
              builder: (ctx) => FiltersScreen(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final foods = ref.watch(foodsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final availableFoods = foods.where((food) {
      if (activeFilters[Filter.glutenFree]! && !food.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !food.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !food.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.glutenFree]! && !food.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = FoodCategoriesScreen(
      availableFoods: availableFoods,
    );
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      final favoriteFoods = ref.watch(favoriteFoodsProvider);
      activePage = FoodsScreen(
        foods: favoriteFoods,
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
