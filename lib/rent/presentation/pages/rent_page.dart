import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_warehouse/common/widgets/row_for_text_and_drop_down.dart';
import 'package:small_warehouse/rent/presentation/state/num_warehouse_notifier.dart';
import 'package:table_calendar/table_calendar.dart';

class RentPage extends StatefulWidget {
  const RentPage({Key? key}) : super(key: key);

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  @override
  Widget build(BuildContext context) {
    const label = 'Select number warehouse -';
    Widget dropdownItem = _DropdownItemState();
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          RowForTextAndDropDownList(label, dropdownItem),
          const Spacer(),
          const DateRent(),
          const Spacer(),
        ],
      ),
    );
  }
}

class DateRent extends StatelessWidget {
  const DateRent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
    );
  }
}

class _DropdownItemState extends StatefulWidget {
  @override
  State<_DropdownItemState> createState() => _DropdownItemStateState();
}

class _DropdownItemStateState extends State<_DropdownItemState> {
  String selectedValue = '0';

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<NumWarehouseNotifier>();
    final warehouses = notifier.warehouseList;
    return Form(
      child: Column(
        children: [
          DropdownButtonFormField(
            isExpanded: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.tealAccent, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.tealAccent, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              fillColor: Colors.tealAccent,
            ),
            validator: (value) => value == null ? "Select a type" : null,
            dropdownColor: Colors.tealAccent,
            value: selectedValue,
            onChanged: _listWarehouseOnHumidity,
            items: warehouses?.map((item) {
              return DropdownMenuItem(
                value: item.warehouseId.toString(),
                child: Text(item.warehouseId.toString()),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _listWarehouseOnHumidity(String? newValue) {
    setState(() {
      selectedValue = newValue!;
    });
  }
}
