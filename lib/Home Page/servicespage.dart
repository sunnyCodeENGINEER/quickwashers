import 'package:flutter/material.dart';
import 'package:quickwashers/models/item_model.dart';

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
    print('here');
    // return Placeholder();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Quickwashers Laundry'),
            const Text('location'),
            const Text('Working hours'),
            Expanded(
              child: ListView.builder(
                  itemCount: testList.length,
                  itemBuilder: (context, index) {
                    final item = testList[index];

                    return ItemRow(item: item);

                    // return ListTile(
                    //   title: Text(item.name),
                    // );
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
          SizedBox(
              width: 52, child: Image.asset(item.imagePath)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(item.name), Text(item.price)],
          ),
          Text(item.action),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white),
              child: const Text('Add'))
        ],
      ),
    );
  }
}
