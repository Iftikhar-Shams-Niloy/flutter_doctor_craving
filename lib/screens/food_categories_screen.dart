import 'package:flutter/material.dart';
import 'package:flutter_doctor_craving/data/dummy_data.dart';
import 'package:flutter_doctor_craving/models/food.dart';
import 'package:flutter_doctor_craving/models/food_category.dart';
import 'package:flutter_doctor_craving/screens/foods_screen.dart';
import 'package:flutter_doctor_craving/widgets/category_grid_item.dart';

class FoodCategoriesScreen extends StatefulWidget {
  const FoodCategoriesScreen({
    super.key,
    required this.availableFoods,
  });

  final List<Food> availableFoods;

  @override
  State<FoodCategoriesScreen> createState() => _FoodCategoriesScreenState();
}

class _FoodCategoriesScreenState extends State<FoodCategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategoryScreen(BuildContext context, FoodCategory foodCategory) {
    final filteredFood = widget.availableFoods
        .where((food) => food.categories.contains(foodCategory.food_id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FoodsScreen(
          foodTitle: foodCategory.food_title,
          foods: filteredFood,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      builder: (context, child) => Padding(
        padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
        child: child,
      ),
    );
  }
}
