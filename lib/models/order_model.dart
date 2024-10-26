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
  });

  // Factory method to create an OrderModel from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    // Create a Map<String, int> from the list of products
    final productsMap = <String, int>{};
    for (var item in json['products']) {
      productsMap[item['product']['_id']] = item['quantity'];
    }

    return OrderModel(
      products: productsMap,
      totalAmount: json['totalAmount'].toDouble(),
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      payment: json['payment'] ??
          'unpaid', // If payment field is missing, default to 'unpaid'
      location: json['location']['name'],
      deliveryTime: json['deliveryTime'] ?? '',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
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
