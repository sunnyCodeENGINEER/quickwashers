import 'package:flutter/material.dart';
import 'package:quickwashers/Confirm%20Order/paystack_web_page.dart';

class SelectPaymentMethodScreen extends StatefulWidget {
  const SelectPaymentMethodScreen({super.key});

  @override
  State<SelectPaymentMethodScreen> createState() =>
      _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  String paymentMethod = '';

  void _updatePaymentMethod(String newMethod) {
    setState(() {
      paymentMethod = newMethod;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left)),
        title: const Text(
          'Select Payment Method',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(45),
            height: 552,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue.withOpacity(0.3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Add Preferred Payment Method'),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Column(
                    children: [
                      PaymentMethodButton(
                        label: 'Card / Mobile Money',
                        image: 'assets/images/Cash on delivery.png',
                        onPressed: () =>
                            _updatePaymentMethod('Card/ Mobile Money'),
                        selected: paymentMethod == 'Card/ Mobile Money'
                            ? true
                            : false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PaymentMethodButton(
                        label: 'Cash on Delivery',
                        image: 'assets/images/Cash on delivery.png',
                        onPressed: () =>
                            _updatePaymentMethod('Cash on Delivery'),
                        selected:
                            paymentMethod == 'Cash on Delivery' ? true : false,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5, foregroundColor: Colors.blue),
                          onPressed: () {
                            // navigate();
                            Navigator.push(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PaystackWebPage()));
                          },
                          child: const SizedBox(
                              width: 240,
                              child: Center(child: Text('Check Out')))),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PaymentMethodButton extends StatefulWidget {
  final String label;
  final String image;
  final VoidCallback onPressed;
  bool selected;
  PaymentMethodButton(
      {super.key,
      required this.label,
      required this.image,
      required this.onPressed,
      required this.selected});

  @override
  State<PaymentMethodButton> createState() => _PaymentMethodButtonState();
}

class _PaymentMethodButtonState extends State<PaymentMethodButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 87,
      width: 320,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 2, color: widget.selected ? Colors.blue : Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                height: 36,
                child: Image.asset(widget.image),
              ),
              Text(widget.label)
            ],
          )),
    );
  }
}
