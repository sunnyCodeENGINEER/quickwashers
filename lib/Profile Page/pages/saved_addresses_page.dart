import 'package:flutter/material.dart';

class SavedAddressesPage extends StatefulWidget {
  const SavedAddressesPage({super.key});

  @override
  State<SavedAddressesPage> createState() => _SavedAddressesPageState();
}

class _SavedAddressesPageState extends State<SavedAddressesPage> {
  String home_address = 'Failed to get address';
  String office_address = '';
  String other_address = '';

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
          'SAVED ADDRESSES',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            child: Row(
              children: [
                Image.asset('assets/images/Home.png'),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Home',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(home_address)
                  ],
                )
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            child: Row(
              children: [
                Image.asset('assets/images/Office_2.png'),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Office',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(home_address)
                  ],
                )
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            child: Row(
              children: [
                Image.asset('assets/images/Home.png'),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Other',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(home_address)
                  ],
                )
              ],
            ),
          ),
          const Divider(),
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
                    onPressed: () {},
                    child: const SizedBox(
                        width: 240, child: Center(child: Text('Add New')))),
              ),
              const Spacer()
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
