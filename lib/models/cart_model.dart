class CartItem {
  final Map<String, int> product;

  CartItem(this.product);
}

class CartModel {
  Map<String, int> products;
  double totalAmount;
  final String createdAt;
  final String updatedAt;

  CartModel({
    required this.products,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
  });
}

CartModel userCart =
    CartModel(products: {}, totalAmount: 0.00, createdAt: '', updatedAt: '');
