import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quickwashers/models/product_model.dart';

import '../models/service_model.dart';

class ServicesService {
  static const String baseUrl = 'https://laundry-main-1.onrender.com/';

  // Function to fetch services from the API
  Future<List<ServiceModel>> fetchServices() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}api/services/'));

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        // Parse the response body and return a list of Service objects
        final List<dynamic> serviceListJson = json.decode(response.body);
        return serviceListJson
            .map((json) => ServiceModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      return [];
    }
  }

  // Function to fetch all products from the API
  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse('${baseUrl}api/product/'));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      // Parse the response body and return a list of Service objects
      final List<dynamic> serviceListJson = json.decode(response.body);
      return serviceListJson
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Function to fetch products from the API by service
  Future<List<ProductModel>> fetchProductsByService(
      {required String serviceId}) async {
    final response =
        await http.get(Uri.parse('${baseUrl}api/product/services/$serviceId'));

    print('${baseUrl}api/product/services/:$serviceId');

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      // Parse the response body and return a list of Service objects
      final List<dynamic> serviceListJson = json.decode(response.body);
      return serviceListJson
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Function to fetch product by ID
  Future<ProductModel> fetchProductById({required String id}) async {
    final response = await http.get(Uri.parse('${baseUrl}api/product/$id'));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final productData = json.decode(response.body);
      return ProductModel.fromJson(
          productData); // Assuming you have a fromJson method in ProductModel
    } else {
      throw Exception('Failed to load product');
    }
  }

  
}
