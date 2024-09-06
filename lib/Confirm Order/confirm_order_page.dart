import 'package:flutter/material.dart';
import 'package:quickwashers/Confirm%20Order/select_payment_method_screen.dart';

import '../Home Page/servicespage.dart';
import '../models/item_model.dart';

class ConfirmOrderPage extends StatelessWidget {
  const ConfirmOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    void navigate() {
      Navigator.push(
          (context),
          MaterialPageRoute(
              builder: (context) => const SelectPaymentMethodScreen()));
    }

    TextEditingController controller = TextEditingController();
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
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Confirm Order'),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Quickwashers Laundry'),
              Expanded(
                child: ListView.builder(
                    itemCount: testList.length,
                    itemBuilder: (context, index) {
                      final item = testList[index];

                      return ItemRow(item: item);
                      // return Container();
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment Info'),
                  Row(
                    children: [Text('Sub Total')],
                  ),
                  Row(
                    children: [Text('Delivery Fees')],
                  ),
                  SizedBox(
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
                  const Row(
                    children: [Text('Total')],
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
