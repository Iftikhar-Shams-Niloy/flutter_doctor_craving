import 'package:flutter/material.dart';
import 'package:flutter_doctor_craving/models/food.dart';

class FoodDetailsScreen extends StatelessWidget {
  const FoodDetailsScreen({
    super.key,
    required this.food,
  });

  final Food food;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food.title),
      ),
      body: Image.network(
        food.imageUrl,
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
