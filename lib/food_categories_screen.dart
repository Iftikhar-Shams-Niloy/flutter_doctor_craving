import 'package:flutter/material.dart';

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
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
        ),
        children: [
          const Text("1"),
          const Text("2"),
          const Text("3"),
          const Text("4"),
          const Text("5"),
          const Text("6"),
        ],
      ),
    );
  }
}
