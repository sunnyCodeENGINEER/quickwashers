import 'dart:math';

import 'package:flutter/material.dart';

class LocationDropDownMenu extends StatefulWidget {
  final bool home;
  const LocationDropDownMenu({super.key, required this.home});

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
          offset: Offset(0, widget.home ? -80 : 0),
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
      style: TextStyle(
          fontSize: widget.home ? 24 : 16,
          fontWeight: FontWeight.bold,
          color: widget.home ? Colors.black : Colors.blue),
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
