// import 'package:flutter_doctor_craving/screens/filters_screen.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_doctor_craving/providers/food_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      });
  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
      (ref) => FiltersNotifier(),
    );

final filteredFoodsProvider = Provider((ref) {
  final foods = ref.watch(foodsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return foods.where((food) {
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
});
