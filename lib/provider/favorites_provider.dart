import "package:flutter_doctor_craving/models/food.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_riverpod/legacy.dart";

class FavoriteFoodsNotifier extends StateNotifier<List<Food>> {
  FavoriteFoodsNotifier() : super([]);

  void toggleFoodFavoriteStatus(Food food) {
    final foodIsFavorite = state.contains(food);

    if (foodIsFavorite) {
      state = state.where((f) => f.id != food.id).toList();
    } else {
      state = [...state, food];
    }
  }
}

final favoriteFoodsProvider =
    StateNotifierProvider<FavoriteFoodsNotifier, List<Food>>((ref) {
      return FavoriteFoodsNotifier();
    });
