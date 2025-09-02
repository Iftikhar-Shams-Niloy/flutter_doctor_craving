import 'package:flutter/material.dart';
import 'package:flutter_doctor_craving/models/food.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({
    super.key,
    required this.food,
  });

  final Food food;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(food.imageUrl),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
