import 'package:flutter/material.dart';
import 'package:quickwashers/Confirm%20Order/components/order_row.dart';
import 'package:quickwashers/Confirm%20Order/select_payment_method_screen.dart';
import 'package:quickwashers/models/cart_model.dart';

import '../models/product_model.dart';

class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage({super.key});

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  double total = 0.00;
  double deliveryFee = 32.00;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var index = 0;
    while (index < userCart.products.length) {
      List<String> keys = userCart.products.keys.toList();
      final id = keys[index];
      ProductModel item = ProductModel(
          name: 'name',
          description: '',
          service: '',
          productType: '',
          price: 0.00,
          imageUrl: '',
          available: true,
          createdAt: '',
          updatedAt: '');
      for (var i in testShop) {
        if (i.id == id) {
          item = i;
        }
      }

      print(userCart.products[id]);

      setState(() {
        total = total + item.price * userCart.products[id]!;
      });
      index += 1;
    }
  }

  void updateTotal() {
    var index = 0;
    while (index < userCart.products.length) {
      List<String> keys = userCart.products.keys.toList();
      final id = keys[index];
      ProductModel item = ProductModel(
          name: 'name',
          description: '',
          service: '',
          productType: '',
          price: 0.00,
          imageUrl: '',
          available: true,
          createdAt: '',
          updatedAt: '');
      for (var i in testShop) {
        if (i.id == id) {
          item = i;
        }
      }

      print(userCart.products[id]);

      setState(() {
        total = total + item.price * userCart.products[id]!;
        print(total);
      });
      index += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    void navigate() {
      Navigator.push(
          (context),
          MaterialPageRoute(
              builder: (context) => const SelectPaymentMethodScreen()));
    }

    TextEditingController controller = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left)),
        title: const Text(
          'Confirm Order',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Quickwashers Laundry'),
              Expanded(
                child:
                    //  ListView.builder(
                    //     itemCount: testList.length,
                    //     itemBuilder: (context, index) {
                    //       final item = testList[index];

                    //       return ItemRow(item: item);
                    //       // return Container();
                    //     }),

                    ListView.builder(
                        itemCount: userCart.products.length,
                        itemBuilder: (context, index) {
                          List<String> keys = userCart.products.keys.toList();
                          final id = keys[index];
                          ProductModel item = ProductModel(
                              name: 'name',
                              description: '',
                              service: '',
                              productType: '',
                              price: 0.00,
                              imageUrl: '',
                              available: true,
                              createdAt: '',
                              updatedAt: '');
                          for (var i in testShop) {
                            if (i.id == id) {
                              item = i;
                            }
                          }

                          print(userCart.products[id]);

                          print(total);

                          // return ProductRow(
                          //   item: item,
                          //   onPressed: updateTotal,
                          // );
                          return OrderRow(item: item, total: total);
                        }),
              ),
              const SizedBox(
                height: 360,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Spacer(),
            Container(
              // width: 322,
              height: 78,

              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 243, 241, 241),
                  borderRadius: BorderRadius.circular(8)),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    hintText:
                        'Any instructions? Eg. Wash white clothes differently',
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 208, 206, 206)),
                    fillColor: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 300,
            )
          ]),
        ),
        Column(
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 172, 213, 246).withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Payment Info'),
                  Row(
                    children: [
                      const Text('Sub Total'),
                      const Spacer(),
                      Text('GHs ${total.toStringAsFixed(2)}')
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Delivery Fees'),
                      const Spacer(),
                      Text('GHs ${deliveryFee.toStringAsFixed(2)}')
                    ],
                  ),
                  const SizedBox(
                    height: 185,
                  )
                ],
              ),
            )
          ],
        ),
        Column(
          children: [
            const Spacer(),
            Container(
              height: 185,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                // borderRadius: BorderRadius.circular(30),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Total'),
                      const Spacer(),
                      Text('GHs ${(total + deliveryFee).toStringAsFixed(2)}')
                    ],
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5, foregroundColor: Colors.blue),
                          onPressed: () {
                            navigate();
                          },
                          child: const SizedBox(
                              width: 240,
                              child: Center(child: Text('Check Out')))),
                      const Spacer()
                    ],
                  )
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}
