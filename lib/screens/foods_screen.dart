import 'package:flutter/material.dart';
import 'package:flutter_doctor_craving/models/food.dart';
import 'package:flutter_doctor_craving/screens/food_details_screen.dart';
import 'package:flutter_doctor_craving/widgets/food_item.dart';

class FoodsScreen extends StatelessWidget {
  const FoodsScreen({
    super.key,
    required this.foodTitle,
    required this.foods,
  });

  final String foodTitle;
  final List<Food> foods;

  void selectFood(BuildContext context, Food food) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FoodDetailsScreen(
          food: food,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget screenContent = ListView.builder(
      itemCount: foods.length,
      itemBuilder: (ctx, idx) => FoodItem(
        food: foods[idx],
        onSelectFood: (food) {
          selectFood(context, food);
        },
      ),
    );

    if (foods.isEmpty) {
      screenContent = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sorry...Nothing to show!!!",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Try any other category!!",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(foodTitle),
      ),
      body: screenContent,
    );
  }
}
