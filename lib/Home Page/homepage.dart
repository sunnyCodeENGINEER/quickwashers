// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:quickwashers/Home%20Page/servicespage.dart';
import 'package:quickwashers/Offer%20Page/offerpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: 24,
          child: Image.asset('assets/images/location Icon.png'),
        ),
        title: const Row(
          children: [
            // SizedBox(
            //   width: 24,
            //   child: Image.asset('assets/images/location Icon.png'),
            // ),
            Text("Home"),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          SizedBox(
              width: 24, child: Image.asset('assets/images/cart Icon.png')),
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(40)),
              child: TextField(
                decoration: InputDecoration(
                  icon: SizedBox(
                    width: 20,
                    child: Image.asset('assets/images/search.png'),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  // prefixIcon: const Icon(Icons.search),
                  hintText: 'Search Laundry Store',

                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(40.0),
                  //   // borderSide: const BorderSide(
                  //   //     color: Color.fromARGB(255, 176, 176, 176), width: 2.0),
                  // ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Laundry Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                GestureDetector(
                    onTap: () {
                      print('tapped');
                      Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) => ServicesPage()));
                    },
                    child: const ServiceTile(
                        title: 'Wash & Fold',
                        image: 'assets/images/Laundry.png')),
                GestureDetector(
                  onTap: () {
                    print('tapped');
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => ServicesPage()));
                  },
                  child: const ServiceTile(
                      title: 'Iron & Fold',
                      image: 'assets/images/Ironing board.png'),
                ),
                GestureDetector(
                  onTap: () {
                    print('tapped');
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => ServicesPage()));
                  },
                  child: const ServiceTile(
                      title: 'Dry Cleaning',
                      image: 'assets/images/Dry cleaning.png'),
                ),
                GestureDetector(
                  onTap: () {
                    print('tapped');
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => ServicesPage()));
                  },
                  child: const ServiceTile(
                      title: 'Household Cleaning',
                      image: 'assets/images/House cleaning.png'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Our Offers',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    // Navigate to OffersPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OfferPage()),
                    );
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
                // Text('View All', style: TextStyle(color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 100,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Flat 50% off on First Order',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer), label: 'Offers'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildServiceTile(String title, String image) {
    return ServiceTile(
      title: title,
      image: image,
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String title;
  final String image;
  const ServiceTile({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 78, child: Image.asset(image)),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
