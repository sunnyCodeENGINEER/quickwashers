import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickwashers/Orders%20Page/current_order_details.dart';

import '../models/order_model.dart';

class TrackingOrderPage extends StatefulWidget {
  final OrderModel order;
  const TrackingOrderPage({super.key, required this.order});

  @override
  State<TrackingOrderPage> createState() => _TrackingOrderPageState();
}

class _TrackingOrderPageState extends State<TrackingOrderPage> {
  String formatDate(String isoDate) {
    // Parse the ISO date string to DateTime
    if (isoDate == "") return 'No date set';
    DateTime dateTime = DateTime.parse(isoDate);

    // Format the date
    String formattedDate = DateFormat('dd MMM, hh:mm a').format(dateTime);

    return formattedDate;
  }

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
          'Tracking Order',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(5, 5), color: Colors.grey, blurRadius: 20)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Status',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Image.asset('assets/images/Group 109.png'),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          // padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        Container(
                          width: 2.0, // Line thickness
                          height: 35.0, // Line height
                          color: Colors.green, // Line color
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          // padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        Container(
                          width: 2.0, // Line thickness
                          height: 35.0, // Line height
                          color: Colors.green, // Line color
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          // padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        Container(
                          width: 2.0, // Line thickness
                          height: 35.0, // Line height
                          color: Colors.green, // Line color
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          // padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        Container(
                          width: 2.0, // Line thickness
                          height: 35.0, // Line height
                          color: Colors.green, // Line color
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          // padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Order Confirmed',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Confirmed on ${formatDate(widget.order.createdAt)}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'Pickup Arranged',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Make Your Laundry Ready To Pick',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'Laundry in Process',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Your Laundry Task Is In Progress',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'Out of Delivery',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Your Laundry Is Out For Delivery',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'Delivery',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Your Laundry Has Been Delivered',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          Container(
              height: 60,
              // width: 200,
              margin: const EdgeInsets.symmetric(horizontal: 60),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CurrentOrderDetails(order: widget.order)));
                },
                child: Row(
                  children: [
                    Text(
                      'GHs ${widget.order.totalAmount} | ${widget.order.payment == 'unpaid' ? 'COD' : 'MOMO'}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const Spacer(),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'View Orders',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.blue,
                            size: 10,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
