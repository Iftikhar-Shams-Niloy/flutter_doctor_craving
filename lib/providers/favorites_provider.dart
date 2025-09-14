import "package:flutter_doctor_craving/models/food.dart";
import "package:flutter_riverpod/legacy.dart";

class FavoriteFoodsNotifier extends StateNotifier<List<Food>> {
  FavoriteFoodsNotifier() : super([]);

  bool toggleFoodFavoriteStatus(Food food) {
    final foodIsFavorite = state.contains(food);

    if (foodIsFavorite) {
      state = state.where((f) => f.id != food.id).toList();
      return false;
    } else {
      state = [...state, food];
      return true;
    }
  }
}

final favoriteFoodsProvider =
    StateNotifierProvider<FavoriteFoodsNotifier, List<Food>>((ref) {
      return FavoriteFoodsNotifier();
    });
