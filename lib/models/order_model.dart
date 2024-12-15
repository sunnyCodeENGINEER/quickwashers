import 'package:quickwashers/models/my_order_product_info.dart';

class OrderModel {
  final Map<String, int> products;
  final double totalAmount;
  final String status;
  final String paymentStatus;
  final String payment;
  final String location;
  final String deliveryTime;
  final String createdAt;
  final String updatedAt;
  final List<MyOrderProductInfo> productInfo;

  OrderModel({
    required this.products,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.payment,
    required this.location,
    required this.deliveryTime,
    required this.createdAt,
    required this.updatedAt,
    required this.productInfo,
  });

  // Factory method to create an OrderModel from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    print(json);
    // Create a Map<String, int> from the list of products
    final productsMap = <String, int>{};
    final List<MyOrderProductInfo> productsInfo = [];

    print(json['products'].runtimeType);

    for (var item in json['products']) {
      // productsMap[item['product']['_id']] = item['quantity'];
      productsMap[item['product'] ?? '123'] = item['quantity'];
      // final productInfo = MyOrderProductInfo(
      //     id: item['product']['_id'],
      //     name: item['product']['name'],
      //     price: item['product']['price'],
      //     service: item['product']['service'],
      //     quantity: item['quantity'] ?? 0);

      final productInfo = MyOrderProductInfo(
          id: item['product'] ?? '',
          name: item['product'] ?? '',
          price: 0.0,
          service: item['product'] ?? '',
          quantity: item['quantity'] ?? 0);

      productsInfo.add(productInfo);
    }
    print('here');

    return OrderModel(
        products: productsMap,
        totalAmount: json['totalAmount'].toDouble(),
        status: json['status'],
        paymentStatus: json['paymentStatus'],
        payment: json['payment'] ??
            'unpaid', // If payment field is missing, default to 'unpaid'
        // location: json['location']['name']
        location: json['location'] ?? '',
        deliveryTime: json['deliveryTime'] ?? '',
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        productInfo: productsInfo);
  }
}

List<OrderModel> userOrders = [];

Future<List<OrderModel>> decodeOrders(dynamic body) async {
  // Ensure that the body is a List before mapping
  List<OrderModel> orders =
      (body as List).map((data) => OrderModel.fromJson(data)).toList();

  // Print the result to verify
  for (var order in orders) {
    print('Order Products: ${order.products}');
    print('Total Amount: \$${order.totalAmount}');
    print('Status: ${order.status}');
    print('Location: ${order.location}');
  }

  return orders; // Return the list wrapped in a Future
}
