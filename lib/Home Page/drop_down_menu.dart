import 'dart:math';

import 'package:flutter/material.dart';

class LocationDropDownMenu extends StatefulWidget {
  const LocationDropDownMenu({super.key});

  @override
  State<LocationDropDownMenu> createState() => _LocationDropDownMenuState();
}

class _LocationDropDownMenuState extends State<LocationDropDownMenu> {
  String? selectedValue;
  List<String> items = ['Home', 'Work', 'Office'];

  @override
  void initState() {
    super.initState();

    selectedValue = items[1];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: const Text('Select Location'),
      value: selectedValue,
      icon: Transform.rotate(
        angle: -pi / 2,
        child: Transform.translate(
          offset: const Offset(0, -80),
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
      style: const TextStyle(fontSize: 24, color: Colors.black),
      underline: const SizedBox.shrink(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
