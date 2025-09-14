import 'package:flutter/material.dart';
import 'package:flutter_doctor_craving/data/dummy_data.dart';
import 'package:flutter_doctor_craving/models/food.dart';
import 'package:flutter_doctor_craving/models/food_category.dart';
import 'package:flutter_doctor_craving/screens/foods_screen.dart';
import 'package:flutter_doctor_craving/widgets/category_grid_item.dart';

class FoodCategoriesScreen extends StatelessWidget {
  const FoodCategoriesScreen({
    super.key,
    required this.onToggleFavorite,
    required this.availableFoods,
  });

  final void Function(Food food) onToggleFavorite;
  final List<Food> availableFoods;

  void _selectCategoryScreen(BuildContext context, FoodCategory foodCategory) {
    final filteredFood = availableFoods
        .where((food) => food.categories.contains(foodCategory.food_id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FoodsScreen(
          foodTitle: foodCategory.food_title,
          foods: filteredFood,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.only(top: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 12,
      ),
      children: [
        for (final foodCategory in availableCategories)
          CategoryGridItem(
            foodCategory: foodCategory,
            onSelectCategory: () {
              _selectCategoryScreen(context, foodCategory);
            },
          ),
      ],
    );
  }
}
