import 'package:flutter/material.dart';

class FoodCategory {
  const FoodCategory({
    required this.food_id,
    required this.food_title,
    this.color = Colors.deepPurpleAccent,
  });

  final String food_id;
  final String food_title;
  final Color color;
}
