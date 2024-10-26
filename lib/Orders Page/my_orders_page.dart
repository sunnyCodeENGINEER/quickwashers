import 'package:flutter/material.dart';
import 'package:quickwashers/Orders%20Page/components/my_order_tile.dart';
import 'package:quickwashers/models/order_model.dart';
import 'package:quickwashers/services/services_service.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final ServicesService _servicesService = ServicesService();

  late Future<List<OrderModel>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    // Fetch orders in initState
    _ordersFuture = _servicesService.retrieveOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
        title: const Text(
          'My Orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: _ordersFuture, // Use the future to get data
        builder: (context, snapshot) {
          // Handle the different states of the Future
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading spinner while fetching data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            // Data fetched successfully, show the UI
            List<OrderModel> userOrders = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.withOpacity(0.2),
                    child: const Text(
                      'ORDER(S) IN PROCESS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // // Loop through the orders to display them
                  // ...userOrders
                  //     .map((order) => MyOrderTile(order: order))
                  //     .toList(),
                  // Filter orders whose status is not 'completed'
                  ...userOrders
                      .where((order) =>
                          order.status != 'completed') // Filter orders
                      .map((order) => MyOrderTile(
                          order: order)) // Map filtered orders to MyOrderTile
                      .toList(),

                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.withOpacity(0.2),
                    child: const Text(
                      'PAST ORDERS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  // Filter orders whose status is not 'completed'
                  ...userOrders
                      .where((order) =>
                          order.status == 'completed') // Filter orders
                      .map((order) => MyOrderTile(
                          order: order)) // Map filtered orders to MyOrderTile
                      .toList(),
                ],
              ),
            );
          } else {
            // If there's no data, display a message
            return const Center(child: Text('No orders found'));
          }
        },
      ),
    );
  }
}
