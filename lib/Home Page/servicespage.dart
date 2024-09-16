import 'package:flutter/material.dart';
import 'package:quickwashers/Home%20Page/components/product_row.dart';
import 'package:quickwashers/models/item_model.dart';
import 'package:quickwashers/models/product_model.dart';

import '../services/services_service.dart';

class ServicesPage extends StatefulWidget {
  final String serviceId;
  const ServicesPage({super.key, required this.serviceId});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {

  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ServicesService().fetchProductsByService(serviceId: widget.serviceId);
    // futureProducts = ServicesService().fetchProducts();
    
    print(futureProducts.toString());
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
              'Laundry Bowl',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child:
                    // ListView.builder(
                    //     itemCount: testShop.length,
                    //     itemBuilder: (context, index) {
                    //       final item = testShop[index];

                    //       return ProductRow(
                    //         item: item,
                    //       );
                    //     }),

                    FutureBuilder<List<ProductModel>>(
                        future: futureProducts,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No services available'));
                          } else {
                            final products = snapshot.data!;
                            return ListView.builder(
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final item = products[index];

                                  return ProductRow(
                                    item: item,
                                  );
                                });
                          }
                        }))
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
