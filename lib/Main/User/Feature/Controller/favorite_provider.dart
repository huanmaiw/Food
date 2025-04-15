import 'package:flutter/material.dart';
import 'package:food/Main/User/Feature/Controller/product_model.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favorites = [];
  double _discountPercent = 0;

  List<Product> getFavorites() => List.unmodifiable(_favorites);

  double get discountPercent => _discountPercent;

  void toggleFavorite(Product product) {
    final index = _favorites.indexWhere((item) => item.title == product.title);

    if (index != -1) {
      _favorites.removeAt(index);
    } else {
      final productWithQuantity = Product(
        title: product.title,
        description: product.description,
        image: product.image,
        price: product.price,
        category: product.category,
        quantity: 1,
      );
      _favorites.add(productWithQuantity);
    }

    notifyListeners();
  }

  /// Xoá sản phẩm khỏi giỏ
  void removeFavorite(Product product) {
    _favorites.removeWhere((item) => item.title == product.title);
    notifyListeners();
  }

  /// Kiểm tra sản phẩm đã có chưa
  bool isExist(Product product) {
    return _favorites.any((item) => item.title == product.title);
  }

  /// Tăng số lượng
  void increaseQuantity(Product product) {
    final index = _favorites.indexWhere((item) => item.title == product.title);
    if (index != -1) {
      _favorites[index].quantity++;
      notifyListeners();
    }
  }

  /// Giảm số lượng
  void decreaseQuantity(Product product) {
    final index = _favorites.indexWhere((item) => item.title == product.title);
    if (index != -1 && _favorites[index].quantity > 1) {
      _favorites[index].quantity--;
      notifyListeners();
    }
  }

  /// Tổng tiền chưa giảm
  double getTotalPrice() {
    return _favorites.fold(
      0.0,
          (total, item) => total + item.price * item.quantity,
    );
  }

  /// Tổng tiền sau giảm
  double getDiscountedTotal() {
    return getTotalPrice() * (1 - _discountPercent / 100);
  }

  /// Áp dụng mã giảm giá
  void applyDiscountCode(String code) {
    if (code.trim().toUpperCase() == 'HUYVIP10') {
      _discountPercent = 10;
    } else {
      _discountPercent = 0;
    }
    notifyListeners();
  }

  /// Xoá mã giảm giá
  void clearDiscount() {
    _discountPercent = 0;
    notifyListeners();
  }

  /// Truy cập từ context
  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}
