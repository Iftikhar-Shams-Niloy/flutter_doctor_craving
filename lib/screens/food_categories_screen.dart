import 'package:flutter/material.dart';
import 'package:flutter_doctor_craving/data/dummy_data.dart';
import 'package:flutter_doctor_craving/models/food_category.dart';
import 'package:flutter_doctor_craving/screens/foods_screen.dart';
import 'package:flutter_doctor_craving/widgets/category_grid_item.dart';

class FoodCategoriesScreen extends StatelessWidget {
  const FoodCategoriesScreen({super.key});

  void _selectCategoryScreen(BuildContext context, FoodCategory foodCategory) {
    final availableFoods = dummyFoods
        .where((food) => food.categories.contains(foodCategory.food_id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FoodsScreen(
          foodTitle: foodCategory.food_title,
          foods: availableFoods,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor Craving"),
      ),
      body: GridView(
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
      ),
    );
  }
}
