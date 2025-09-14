import 'package:flutter/material.dart';
import 'package:flutter_doctor_craving/models/food.dart';
import 'package:flutter_doctor_craving/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodDetailsScreen extends ConsumerWidget {
  const FoodDetailsScreen({
    super.key,
    required this.food,
    // required this.onToggleFavorite,
  });

  final Food food;
  // final void Function(Food food) onToggleFavorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteFoodsProvider.notifier)
                  .toggleFoodFavoriteStatus(food);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded ? 'Added to favorite!' : 'Removed from favorite!',
                  ),
                ),
              );
            },
            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              food.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              "Ingredient",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // <-- Ingredients List Here --> //
            for (final ingredient in food.ingredients)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  ingredient,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                ),
              ),
            const SizedBox(
              height: 16,
            ),
            // <-- Steps Here -->
            Text(
              "Steps",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            for (final step in food.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
