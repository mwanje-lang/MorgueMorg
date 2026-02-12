import 'package:flutter/foundation.dart';

class FavoritesProvider with ChangeNotifier {
  final Set<int> _favoriteProductIds = {};

  Set<int> get favoriteProductIds => _favoriteProductIds;

  bool isFavorite(int productId) {
    return _favoriteProductIds.contains(productId);
  }

  void toggleFavorite(int productId) {
    if (_favoriteProductIds.contains(productId)) {
      _favoriteProductIds.remove(productId);
    } else {
      _favoriteProductIds.add(productId);
    }
    notifyListeners();
  }

  void addFavorite(int productId) {
    _favoriteProductIds.add(productId);
    notifyListeners();
  }

  void removeFavorite(int productId) {
    _favoriteProductIds.remove(productId);
    notifyListeners();
  }
}
