class OrderModel {
  final Map<String, int> products;
  final double totalAmount;
  final String status;
  final String paymentStatus;

  OrderModel({
    required this.products,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
  });
}
