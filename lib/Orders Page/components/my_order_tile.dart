import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickwashers/Orders%20Page/tracking_order_page.dart';
// import 'package:quickwashers/models/display_products.dart';
import 'package:quickwashers/models/order_model.dart';

class MyOrderTile extends StatefulWidget {
  final OrderModel order;
  // final List<DisplayProducts> products;
  const MyOrderTile({
    super.key,
    required this.order,
    // required this.products,
  });

  @override
  State<MyOrderTile> createState() => _MyOrderTileState();
}

class _MyOrderTileState extends State<MyOrderTile> {
  int productCount = 0;
  List keys = [];
  List quantity = [];

  String formatDate(String isoDate) {
    // Parse the ISO date string to DateTime
    if (isoDate == "") return 'No date set';
    DateTime dateTime = DateTime.parse(isoDate);

    // Format the date
    String formattedDate = DateFormat('dd MMM, hh:mm a').format(dateTime);

    return formattedDate;
  }

  @override
  void initState() {
    super.initState();

    List k = widget.order.products.keys.toList();
    List v = widget.order.products.values.toList();

    productCount = k.length > 3 ? 3 : k.length;

    int i = 0;

    while ((i) < productCount) {
      keys.add(k[i]);
      quantity.add(v[i]);
      i += 1;
    }

    print('$keys : $quantity');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(3, 3)),
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(-3, -3))
          ]),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TrackingOrderPage(order: widget.order)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.order.status == 'completed' ? 'Delivered' : 'Delivery',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDate(widget.order.deliveryTime),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Text(
                  '${widget.order.totalAmount} | MOMO',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                )
              ],
            ),
            Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ...keys.map(
                    (name) => Text(
                      name,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'service',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      Text(
                        'service',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      )
                    ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
