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
  final ServicesService _servicesService = ServicesService();
  late Future<List<ProductModel>> futureProducts;

  String category = 'Man';
  List<String> categories = ['Man', 'Woman', 'Kids', 'Others'];

  @override
  void initState() {
    super.initState();
    var newCart = ServicesService().retrieveCart();
    // userCart.products = newCart.items;

    futureProducts =
        ServicesService().fetchProductsByService(serviceId: widget.serviceId);
    // futureProducts = ServicesService().fetchProducts();

    print(futureProducts.toString());
  }

  void updateUserCart() async {
    var response = _servicesService.updateCart();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            // Navigator.pop(context);
            updateUserCart();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: categories
                  .map((item) => TextButton(
                      onPressed: () {
                        setState(() {
                          category = item;
                        });
                      },
                      child: SizedBox(
                        width: 60,
                        child: Center(
                          child: Text(
                            item.toUpperCase(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color:
                                  item == category ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ),
                      )))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: categories
                    .map((item) => SizedBox(
                          width: 60,
                          child: item == category
                              ? const Center(
                                  child: Divider(
                                    color: Colors.blue,
                                    thickness: 3,
                                    // indent: 2,
                                  ),
                                )
                              : Container(),
                        ))
                    .toList(),
              ),
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
                            var sortedProducts = [];
                            for (var product in products) {
                              print(
                                  '${product.productType.toLowerCase()} --- ${category.toLowerCase()}');
                              if (product.productType.toLowerCase() ==
                                  category.toLowerCase()) {
                                sortedProducts.add(product);
                              }
                            }

                            return ListView.builder(
                                itemCount: sortedProducts.length,
                                itemBuilder: (context, index) {
                                  final item = sortedProducts[index];

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
