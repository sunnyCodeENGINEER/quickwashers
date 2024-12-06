import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickwashers/models/cart_model.dart';
import 'package:quickwashers/models/user_details.dart';

import 'select_payment_method_screen.dart';

class SelectOrderLocation extends StatefulWidget {
  const SelectOrderLocation({super.key});

  @override
  State<SelectOrderLocation> createState() => _SelectOrderLocationState();
}

class _SelectOrderLocationState extends State<SelectOrderLocation> {
  DateTime? selectedDateTime;
  DateTime? deliveryDateTime;

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set the current date as initial
      firstDate: DateTime.now(), // Allow selection from today onwards
      lastDate: DateTime(2100), // Set an upper limit
    );

    if (pickedDate != null) {
      // Handle selected date
      print('Selected Date: ${pickedDate.toLocal().toUtc().toIso8601String()}');
      // pickUpTime = '${pickedDate.toLocal().toUtc().toIso8601String()}Z';
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    // Step 1: Pick a date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date
      firstDate: DateTime.now(), // Today onwards
      lastDate: DateTime(2100), // Some future date
    );

    if (pickedDate != null) {
      // Step 2: Pick a time
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(), // Current time
      );

      if (pickedTime != null) {
        // Combine the date and time into a DateTime object
        final DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          selectedDateTime = combinedDateTime;
          print(
              'Selected Date: ${combinedDateTime.toLocal().toUtc().toIso8601String()}');
          pickUpTime = combinedDateTime.toLocal().toUtc().toIso8601String();
          var _ = combinedDateTime.toLocal().add(const Duration(hours: 24));
          dropOffTime = combinedDateTime
              .toLocal()
              .add(const Duration(hours: 24))
              .toUtc()
              .toIso8601String();
        });
      }
    }
  }

  String formatDate(String isoDate) {
    // Parse the ISO date string to DateTime
    if (isoDate == "") return 'No date set';
    DateTime dateTime = DateTime.parse(isoDate);

    // Format the date
    String formattedDate = DateFormat('dd MMM, hh:mm a').format(dateTime);

    return formattedDate;
  }

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
    List<String> items = ['Home', 'Work', 'Office'];

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
              const SizedBox(
                height: 20,
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
                  DropdownButton<String>(
                    hint: const Text('Select Location'),
                    value: pickUpLocation,
                    icon: Transform.rotate(
                      angle: -pi / 2,
                      child: Transform.translate(
                        offset: const Offset(0, 0),
                        child: const Icon(
                          Icons.chevron_left,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    iconSize: 24,
                    elevation: 16,
                    menuWidth: 120,
                    isExpanded: false,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    underline: const SizedBox.shrink(),
                    onChanged: (String? newValue) {
                      setState(() {
                        pickUpLocation = newValue ?? 'Home';
                      });
                    },
                    items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PICKUP TIME',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(formatDate(selectedDateTime.toString()))
                        ],
                      )
                    ],
                  ),
                  RotatedBox(
                    quarterTurns: -1,
                    child: IconButton(
                        onPressed: () => _selectDateTime(context),
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.blue,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/Frame 28.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
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
                          Text('DROP OFF LOCATION')
                        ],
                      )
                    ],
                  ),
                  // LocationDropDownMenu(
                  //   home: false,
                  //   value: dropOffLocation,
                  // )
                  DropdownButton<String>(
                    hint: const Text('Select Location'),
                    value: dropOffLocation,
                    icon: Transform.rotate(
                      angle: -pi / 2,
                      child: Transform.translate(
                        offset: const Offset(0, 0),
                        child: const Icon(
                          Icons.chevron_left,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    iconSize: 24,
                    elevation: 16,
                    menuWidth: 120,
                    isExpanded: false,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    underline: const SizedBox.shrink(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropOffLocation = newValue ?? 'Home';
                      });
                    },
                    items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'DROP-OFF TIME',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(formatDate(dropOffTime.toString()))
                        ],
                      )
                    ],
                  ),
                  // const LocationDropDownMenu(
                  //   home: false,
                  // )
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
                          print('pickup $dropOffLocation');
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
