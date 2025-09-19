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
  late AnimationController
  //! <--- Making a Animation controller named "_animationController" --->
  _animationController;

  //! <--- Set the _animationController configs in initState() --->
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
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

      //* <--- Sliding Transition Here --->
      builder: (context, child) => SlideTransition(
        position:
            Tween(
              begin: Offset(0.0, 0.3),
              end: Offset(0, 0),
              //* <--- Getting more control on how the animation is played --->
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
        child: child,
      ),
    );
  }
}
