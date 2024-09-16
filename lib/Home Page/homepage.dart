// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:quickwashers/Confirm%20Order/confirm_order_page.dart';
import 'package:quickwashers/Home%20Page/drop_down_menu.dart';
import 'package:quickwashers/Home%20Page/servicespage.dart';
import 'package:quickwashers/Location%20Screen/user_location_screen.dart';
import 'package:quickwashers/Offer%20Page/offerpage.dart';
import 'package:quickwashers/models/service_model.dart';
import 'package:quickwashers/services/services_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ServiceModel>> futureServices;

  @override
  void initState() {
    super.initState();
    try {
      futureServices = ServicesService().fetchServices();
      print(futureServices.toString());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load services.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: 24,
          child: IconButton(
              onPressed: () {
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => const UserLocationScreen()));
              },
              icon: Image.asset('assets/images/location Icon.png')),
        ),
        title: const Row(
          children: [
            LocationDropDownMenu(),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          SizedBox(
            width: 40,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  (context),
                  MaterialPageRoute(
                    builder: (context) => const ConfirmOrderPage(),
                  ),
                );
              },
              icon: Image.asset(
                'assets/images/cart Icon.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIconColor: const Color.fromARGB(255, 55, 55, 55),
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search Laundry Service',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 224, 222, 222), width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text('Laundry Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text('Select your preferred service(s)',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                // GestureDetector(
                //     onTap: () {
                //       Navigator.push(
                //           (context),
                //           MaterialPageRoute(
                //               builder: (context) => ServicesPage()));
                //     },
                //     child: const ServiceTile(
                //         title: 'Wash & Fold',
                //         image: 'assets/images/Laundry.png')),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //         (context),
                //         MaterialPageRoute(
                //             builder: (context) => ServicesPage()));
                //   },
                //   child: const ServiceTile(
                //       title: 'Iron & Fold',
                //       image: 'assets/images/Ironing board.png'),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //         (context),
                //         MaterialPageRoute(
                //             builder: (context) => ServicesPage()));
                //   },
                //   child: const ServiceTile(
                //       title: 'Dry Cleaning',
                //       image: 'assets/images/Dry cleaning.png'),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //         (context),
                //         MaterialPageRoute(
                //             builder: (context) => ServicesPage()));
                //   },
                //   child: const ServiceTile(
                //       title: 'Household Cleaning',
                //       image: 'assets/images/House cleaning.png'),
                // ),

                FutureBuilder<List<ServiceModel>>(
                  future: futureServices,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No services available'));
                    } else {
                      final services = snapshot.data!;
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 columns
                          childAspectRatio: 3 / 2, // Aspect ratio for each item
                          crossAxisSpacing: 10, // Space between columns
                          mainAxisSpacing: 10, // Space between rows
                        ),
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          final service = services[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ServicesPage(
                                    serviceId: service.id,
                                  ),
                                ),
                              );
                            },
                            child: ServiceTile(
                              title: service.name,
                              image:
                                  'assets/images/House cleaning.png', // Dynamically provide an image
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
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
            const OurOffersTile(),
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

class OurOffersTile extends StatelessWidget {
  const OurOffersTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      width: 260,
      // color: Colors.blue,
      child: Center(
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Column(
                children: [
                  const Text(
                    'Flat 50% off on First Order',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Text(
                        'View all offers',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset('assets/images/Vector.png')
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            Image.asset('assets/images/Washing machine.png')
          ],
        ),
      ),
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
