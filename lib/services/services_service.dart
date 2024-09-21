import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quickwashers/models/cart_model.dart';
import 'package:quickwashers/models/product_model.dart';

import '../models/service_model.dart';
import '../models/user_details.dart';

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
          productData); 
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<Map<String, dynamic>> retrieveCart() async {
    final url = Uri.parse('${baseUrl}api/cart/');
    print(currentUser.token);

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${currentUser.token}',
      },
    );

    print(currentUser.token);
    print(response.body);
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      userCart = CartModel.fromJson({
        'items': body[0]['items'],
        'totalAmount': body[0]['totalAmount'],
        'createdAt': body[0]['createdAt'],
        'updatedAt': body[0]['updatedAt'],
      });
      return {
        'successful': true,
        'items': body[0]['items'],
        'totalAmount': body[0]['totalAmount'],
      };
    } else {
      return {
        'successful': false,
        'msg': body['msg'],
      };
    }
  }

  Future<Map<String, dynamic>> updateCart() async {
    final url = Uri.parse('${baseUrl}api/cart/add');
    print(currentUser.token);

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${currentUser.token}',
        },
        body: cartToJson(userCart));

    print(response.statusCode);
    print(response.body);
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        'successful': true,
        'items': body['items'],
        'totalAmount': body['totalAmount'],
      };
    } else {
      return {
        'successful': false,
        'msg': body['msg'],
      };
    }
  }
}
