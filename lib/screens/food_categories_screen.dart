import 'package:flutter/material.dart';
import 'package:flutter_doctor_craving/data/dummy_data.dart';
import 'package:flutter_doctor_craving/widgets/category_grid_item.dart';

class FoodCategoriesScreen extends StatelessWidget {
  const FoodCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor Craving"),
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 6,
          mainAxisSpacing: 12,
        ),
        children: [
          for (final foodCategory in availableCategories)
            CategoryGridItem(foodCategory: foodCategory),
        ],
      ),
    );
  }
}
