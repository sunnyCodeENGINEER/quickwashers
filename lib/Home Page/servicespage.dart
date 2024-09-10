import 'package:flutter/material.dart';
import 'package:quickwashers/Home%20Page/components/product_row.dart';
import 'package:quickwashers/models/item_model.dart';
import 'package:quickwashers/models/product_model.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({super.key});

  final testList = [
    ItemModel(
        name: 'T-Shirts',
        action: 'Wash Only',
        quantity: 0,
        price: 'GHS 100.00',
        imagePath: 'assets/images/Tshirt.png'),
    ItemModel(
        name: 'Shirts',
        action: 'Wash Only',
        quantity: 0,
        price: 'GHS 100.00',
        imagePath: 'assets/images/Shirt.png'),
    ItemModel(
        name: 'Jeans',
        action: 'Wash Only',
        quantity: 0,
        price: 'GHS 100.00',
        imagePath: 'assets/images/Jeans.png'),
    ItemModel(
        name: 'Jackets',
        action: 'Wash Only',
        quantity: 0,
        price: 'GHS 100.00',
        imagePath: 'assets/images/Tshirt.png'),
    ItemModel(
        name: 'Shorts',
        action: 'Wash Only',
        quantity: 0,
        price: 'GHS 100.00',
        imagePath: 'assets/images/Football shorts.png'),
    ItemModel(
        name: 'Socks',
        action: 'Wash Only',
        quantity: 0,
        price: 'GHS 100.00',
        imagePath: 'assets/images/Tshirt.png'),
    ItemModel(
        name: 'Face towel',
        action: 'Wash Only',
        quantity: 0,
        price: 'GHS 100.00',
        imagePath: 'assets/images/Tshirt.png'),
    ItemModel(
        name: 'T-Shirts',
        action: 'Wash Only',
        quantity: 0,
        price: 'GHS 100.00',
        imagePath: 'assets/images/Tshirt.png'),
  ];

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
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quickwashers Laundry',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'location',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const Text(
              'Working hours',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: testShop.length,
                  itemBuilder: (context, index) {
                    final item = testShop[index];

                    return ProductRow(
                      item: item,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 52, child: Image.asset(item.imagePath)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(item.name), Text(item.price)],
          ),
          Text(item.action),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
              child: const Text('Add'))
        ],
      ),
    );
  }
}
