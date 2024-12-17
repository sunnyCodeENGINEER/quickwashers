import 'package:flutter/material.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Offers"),
        // backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIconColor: Colors.grey,
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.125),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search Offer',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.2),
                      width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(vertical: 40),
                    height: 135,
                    width: 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Positioned(
                              child: SizedBox(
                                width: 150,
                                child: Text(
                                  'Flat 50% off on First Order',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 20),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blue),
                              child: const Text('Order'),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 40,
                  child: SizedBox(
                    width: 140,
                    child: Image.asset(
                      'assets/images/Laundry.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildOfferTile(),
                  _buildOfferTile(),
                  _buildOfferTile(),
                  _buildOfferTile(),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.local_offer), label: 'Offers'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      // ),
    );
  }

  Widget _buildOfferTile() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
              offset: const Offset(2, 2), color: Colors.black.withOpacity(0.3))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Image.asset('assets/images/Washing machine.png'),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 5),
                  width: 150,
                  child: const Text(
                    'Flat 50% off on First Order',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue),
                child: const Text('Check Out'),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
