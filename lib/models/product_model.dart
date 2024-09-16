class Services {
  String id;
  String name;

  Services({required this.id, required this.name});
}

class ProductModel {
  // var id = Uuid().v4();
  final String id;
  final String name;
  final String description;
  // final String service;
  final Services service;
  final String productType;
  final double price;
  final String imageUrl;
  final bool available;
  final String createdAt;
  final String updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.service,
    required this.productType,
    required this.price,
    required this.imageUrl,
    required this.available,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Service object from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      service:
          Services(id: json['service']['_id'], name: json['service']['name']),
      productType: json['productType'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      available: json['available'],
      createdAt: DateTime.parse(json['createdAt']).toString(),
      updatedAt: DateTime.parse(json['updatedAt']).toString(),
    );
  }

  // Method to convert a Service object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'service': service,
      'productType': productType,
      'price': price,
      'imageUrl': imageUrl,
      'available': available,
      'createdAt': DateTime.parse(createdAt).toIso8601String(),
      'updatedAt': DateTime.parse(updatedAt).toIso8601String(),
    };
  }
}

List<ProductModel> allProducts = [];

var testShop = [
  ProductModel(
      id: '0000',
      name: 'T-Shirts',
      service: Services(id: 'id', name: 'Wash Only'),
      // quantity: 0,
      price: 100.00,
      imageUrl: 'assets/images/Tshirt.png',
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: ''),
  ProductModel(
      id: '0001',
      name: 'Shirts',
      service: Services(id: 'id', name: 'Wash Only'),
      // quantity: 0,
      price: 100.00,
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: '',
      imageUrl: 'assets/images/Shirt.png'),
  ProductModel(
      id: '0002',
      name: 'Jeans',
      service: Services(id: 'id', name: 'Wash Only'),
      // quantity: 0,
      price: 100.00,
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: '',
      imageUrl: 'assets/images/Jeans.png'),
  ProductModel(
      id: '0003',
      name: 'Jackets',
      service: Services(id: 'id', name: 'Wash Only'),
      // quantity: 0,
      price: 100.00,
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: '',
      imageUrl: 'assets/images/Shirt.png'),
  ProductModel(
      id: '0004',
      name: 'Shorts',
      service: Services(id: 'id', name: 'Wash Only'),
      // quantity: 0,
      price: 100.00,
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: '',
      imageUrl: 'assets/images/Football shorts.png'),
  ProductModel(
      id: '0005',
      name: 'Socks',
      service: Services(id: 'id', name: 'Wash Only'),
      // quantity: 0,
      price: 100.00,
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: '',
      imageUrl: 'assets/images/Shirt.png'),
  ProductModel(
      id: '0006',
      name: 'Face Towel',
      service: Services(id: 'id', name: 'Wash Only'),
      // quantity: 0,
      price: 100.00,
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: '',
      imageUrl: 'assets/images/Shirt.png'),
];
