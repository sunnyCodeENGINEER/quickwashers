import 'package:flutter/material.dart';
import 'package:quickwashers/Orders%20Page/components/my_order_tile.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'My Orders',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
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
            const SizedBox(
              height: 10,
            ),
            const MyOrderTile(),
            const SizedBox(
              height: 10,
            ),
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
            )
          ],
        ));
  }
}
