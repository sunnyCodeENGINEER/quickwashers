import 'package:uuid/uuid.dart';

class ProductModel {
  var id = Uuid().v4();
  final String name;
  final String description;
  final String service;
  final String productType;
  final double price;
  final String imageUrl;
  final bool available;
  final String createdAt;
  final String updatedAt;

  ProductModel({
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
}

var testShop = [
  ProductModel(
      name: 'T-Shirts',
      service: 'Wash Only',
      // quantity: 0,
      price: 100.00,
      imageUrl: 'assets/images/Tshirt.png',
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: ''),
  ProductModel(
      name: 'Shirts',
      service: 'Wash Only',
      // quantity: 0,
      price: 100.00,
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: '',
      imageUrl: 'assets/images/Shirt.png'),
  ProductModel(
      name: 'Jeans',
      service: 'Wash Only',
      // quantity: 0,
      price: 100.00,
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: '',
      imageUrl: 'assets/images/Jeans.png'),
  ProductModel(
      name: 'Jackets',
      service: 'Wash Only',
      // quantity: 0,
      price: 100.00,
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: '',
      imageUrl: 'assets/images/Shirt.png'),
  ProductModel(
      name: 'Shorts',
      service: 'Wash Only',
      // quantity: 0,
      price: 100.00,
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: '',
      imageUrl: 'assets/images/Football shorts.png'),
  ProductModel(
      name: 'Socks',
      service: 'Wash Only',
      // quantity: 0,
      price: 100.00,
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: '',
      imageUrl: 'assets/images/Shirt.png'),
  ProductModel(
      name: 'Face Towel',
      service: 'Wash Only',
      // quantity: 0,
      price: 100.00,
      description: '',
      productType: '',
      available: true,
      createdAt: '',
      updatedAt: '',
      imageUrl: 'assets/images/Shirt.png'),
  
];
