import 'package:flutter/material.dart';
import 'package:flutter_doctor_craving/models/food_category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.foodCategory});

  final FoodCategory foodCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              foodCategory.color.withValues(alpha: 0.55),
              foodCategory.color.withValues(alpha: 0.95),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          foodCategory.food_title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
