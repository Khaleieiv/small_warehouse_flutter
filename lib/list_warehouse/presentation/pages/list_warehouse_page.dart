import 'package:flutter/material.dart';

class ListWarehousePage extends StatefulWidget {
  const ListWarehousePage({Key? key}) : super(key: key);

  @override
  State<ListWarehousePage> createState() => _ListWarehousePageState();
}

class _ListWarehousePageState extends State<ListWarehousePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          _DropdownItemState(),
        ],
      ),
    );
  }
}

class _DropdownItemState extends StatefulWidget {
  @override
  State<_DropdownItemState> createState() => _DropdownItemStateState();
}

class _DropdownItemStateState extends State<_DropdownItemState> {
  String? selectedValue;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "USA", child: Text("USA")),
      const DropdownMenuItem(value: "Canada", child: Text("Canada")),
      const DropdownMenuItem(value: "Brazil", child: Text("Brazil")),
      const DropdownMenuItem(value: "England", child: Text("England")),
    ];
    return menuItems;
  }

  final _dropdownFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _dropdownFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.blueAccent,
              ),
              validator: (value) => value == null ? "Select a country" : null,
              dropdownColor: Colors.blueAccent,
              value: selectedValue,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: dropdownItems),
        ],
      ),
    );
  }
}
