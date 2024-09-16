import 'dart:convert';

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

  // Factory method to create CartModel from a JSON map
  factory CartModel.fromJson(Map<String, dynamic> json) {
    // Extract the items array and convert it into a Map<String, int> for products
    Map<String, int> productsMap = {};
    for (var item in json['items']) {
      String productId = item['product'];
      int quantity = item['quantity'];
      productsMap[productId] = quantity;
    }

    return CartModel(
      products: productsMap,
      totalAmount: json['totalAmount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

CartModel userCart =
    CartModel(products: {}, totalAmount: 0.00, createdAt: '', updatedAt: '');

String cartToJson(CartModel cart) {
  // Convert the products map to a list of productId and quantity objects
  List<Map<String, dynamic>> productsList = cart.products.entries.map((entry) {
    return {
      "productId": entry.key,
      "quantity": entry.value,
    };
  }).toList();

  // Create the final JSON structure
  Map<String, dynamic> cartJson = {
    "products": productsList,
  };

  // Convert the map to a JSON string
  return jsonEncode(cartJson);
}