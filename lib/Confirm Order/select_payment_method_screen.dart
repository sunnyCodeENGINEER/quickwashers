import 'package:flutter/material.dart';

class SelectPaymentMethodScreen extends StatelessWidget {
  const SelectPaymentMethodScreen({super.key});

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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Preferred Payment Method'),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Column(
                    children: [
                      PaymentMethodButton(
                        label: 'Card / Mobile Money',
                        image: 'assets/images/Cash on delivery.png',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PaymentMethodButton(
                        label: 'Cash on Delivery',
                        image: 'assets/images/Cash on delivery.png',
                      )
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

class PaymentMethodButton extends StatelessWidget {
  final String label;
  final String image;
  const PaymentMethodButton({
    super.key,
    required this.label,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 87,
      width: 320,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                height: 36,
                child: Image.asset(image),
              ),
              Text(label)
            ],
          )),
    );
  }
}
