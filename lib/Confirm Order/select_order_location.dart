import 'package:flutter/material.dart';
import 'package:quickwashers/Home%20Page/drop_down_menu.dart';
import 'package:quickwashers/models/cart_model.dart';

import 'select_payment_method_screen.dart';

class SelectOrderLocation extends StatefulWidget {
  const SelectOrderLocation({super.key});

  @override
  State<SelectOrderLocation> createState() => _SelectOrderLocationState();
}

class _SelectOrderLocationState extends State<SelectOrderLocation> {
  void navigate() {
    Navigator.push(
        (context),
        MaterialPageRoute(
            builder: (context) => SelectPaymentMethodScreen(
                  total: userCart.totalAmount,
                )));
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
          'Select Location & Time',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(children: [
          Column(
            children: [
              Image.asset('assets/images/Frame 27.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/location Icon.png'),
                      const SizedBox(
                        width: 5,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PICKUP ADDRESS',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text('PICKUP ADDRESS')
                        ],
                      )
                    ],
                  ),
                  const LocationDropDownMenu(
                    home: false,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/clock-04.png'),
                      const SizedBox(
                        width: 5,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PICKUP TIME',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text('PICKUP TIME')
                        ],
                      )
                    ],
                  ),
                  const LocationDropDownMenu(
                    home: false,
                  )
                ],
              ),
              Image.asset(
                'assets/images/Frame 28.png',
                fit: BoxFit.cover,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/location Icon.png'),
                      const SizedBox(
                        width: 5,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DROP-OFF ADDRESS',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text('TIME')
                        ],
                      )
                    ],
                  ),
                  const LocationDropDownMenu(
                    home: false,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/clock-04.png',
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DROP-OFF ADDRESS',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text('TIME')
                        ],
                      )
                    ],
                  ),
                  const LocationDropDownMenu(
                    home: false,
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 5,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          navigate();
                        },
                        child: const SizedBox(
                            width: 240,
                            child: Center(child: Text('Check Out')))),
                  ),
                  const Spacer()
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          )
        ]),
      ),
    );
  }
}
