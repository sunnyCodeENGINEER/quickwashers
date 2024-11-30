import 'dart:ffi';

class MyOrderProductInfo {
  String id;
  String name;
  String service;
  double price;
  int quantity;

  MyOrderProductInfo({
    required this.id,
    required this.name,
    required this.price,
    required this.service,
    required this.quantity,
  });

  factory MyOrderProductInfo.fromJson(Map<String, dynamic> json) {
    return MyOrderProductInfo(
      id: json['_id'] as String,
      name: json['name'] as String,
      service: json['service'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int
    );
  }
}
