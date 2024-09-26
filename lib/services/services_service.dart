import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quickwashers/models/cart_model.dart';
import 'package:quickwashers/models/product_model.dart';

import '../models/service_model.dart';
import '../models/user_details.dart';

String paymentUrl = '';

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
      return ProductModel.fromJson(productData);
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

  Future<Map<String, dynamic>> placeOrder({
    required String method,
    required String location,
    required double totalAmount,
  }) async {
    final url = Uri.parse('${baseUrl}api/orders/create');
    print(currentUser.token);

    List<Map<String, dynamic>> productsList = [];

    userCart.products.entries.forEach((entry) {
      productsList.add({
        "product": entry.key,
        "quantity": entry.value,
      });
    });

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${currentUser.token}',
        },
        body: jsonEncode({
          // "customer": "64f3e4c8f75e3b001c73aef4",
          'products': userCart.products.entries.map((entry) {
            return {'product': entry.key, 'quantity': entry.value};
          }).toList(),
          'totalAmount': 319.96,
          'status': 'pending',
          'paymentMethod': method,
          'location': '66d496c6bbc8651b3d8b5053',
          // 'deliveryTime': "2024-09-05T14:30:00Z"
        })

//         body: jsonEncode({
//     // "customer": "64f3e4c8f75e3b001c73aef4",
//     "products": [
//         {
//             "product": "66d3097fb5d83a680725f6e6",
//             "quantity": 2
//         }
//     ],
//     "totalAmount": 150,
//     "status": "pending",
//     "paymentMethod": "card",
//     "location": "66d496c6bbc8651b3d8b5053",
//     "deliveryTime": "2024-09-05T14:30:00Z"
// })
        );

    print(jsonEncode({
      'products': userCart.products.entries.map((entry) {
        return {
          "product": entry.key,
          "quantity": entry.value,
        };
      }).toList(),
      'totalAmount': totalAmount,
      'status': 'pending',
      'paymentMethod': method,
      'location': location,
      // 'deliveryTime': deliveryTime,
    }));
    print(userCart.products.entries.map((entry) {
      return {
        "productId": entry.key,
        "quantity": entry.value,
      };
    }).toList());

    print(response.statusCode);
    print(response.body);
    final body = jsonDecode(response.body);

    if (method == 'card') print(body['paymentUrl']);

    paymentUrl = body['paymentUrl'];
    
    if (response.statusCode == 201) {
      return {
        'successful': true,
        'msg': body[method == 'card' ? 'paymentUrl' : 'message'],
        // 'totalAmount': body['totalAmount'],
      };
    } else {
      return {
        'successful': false,
        'msg': body['msg'],
      };
    }
  }
}
