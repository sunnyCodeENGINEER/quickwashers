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
  });
}
