import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_warehouse/auth/presentation/state/auth_notifier.dart';
import 'package:small_warehouse/common/config/string_constant.dart';
import 'package:small_warehouse/common/widgets/custom_snack_bar.dart';
import 'package:small_warehouse/common/widgets/row_for_text_and_drop_down.dart';
import 'package:small_warehouse/rent/presentation/state/num_warehouse_notifier.dart';
import 'package:small_warehouse/rent/presentation/state/rent_state.dart';
import 'package:table_calendar/table_calendar.dart';

class RentPage extends StatefulWidget {
  const RentPage({Key? key}) : super(key: key);

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  @override
  Widget build(BuildContext context) {
    final label = context.getString('rent.label');
    Widget dropdownItem = _DropdownItemState();
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Text(
            context.getString('rent.text'),
            style: const TextStyle(
              fontSize: 26,
            ),
          ),
          const Spacer(),
          RowForTextAndDropDownList(label, dropdownItem),
          const Spacer(),
          const _DateRent(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                context.getString('rent.press_button_rent'),
                style: const TextStyle(fontSize: 18),
              ),
              IconButton(
                onPressed: _registerButtonPressed,
                splashColor: Colors.lightGreenAccent,
                icon: const Icon(
                  Icons.shopping_basket_outlined,
                ),
              )
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void _registerButtonPressed() {
    final rentNotifier = Provider.of<RentNotifier>(context, listen: false);
    final setDate = rentNotifier.dateTime;

    final warehouseNotifier = context.read<NumWarehouseNotifier>();
    final warehouseData = warehouseNotifier.currentWarehouses;

    final authNotifier = context.read<AuthNotifier>();
    final userData = authNotifier.currentUser;

    final dDay = DateTime.now();
    final localDay = dDay.toLocal();
    DateTime data = localDay.toUtc();

    if (userData == null) {
      final message = context.getString('rent.message.error.error');
      CustomSnackBar.snackBarError(StringConstants.title, message, context);
      return;
    }
    if (warehouseData == null) {
      final message =
          context.getString('rent.message.error.not_selected.warehouse');
      CustomSnackBar.snackBarError(StringConstants.title, message, context);
      return;
    }
    if (setDate == null) {
      final message = context.getString('rent.message.error.not_selected_date');
      CustomSnackBar.snackBarError(StringConstants.title, message, context);
      return;
    }

    rentNotifier.rentWarehouse(
      userData.name,
      userData.phone,
      userData.email,
      warehouseData.size,
      warehouseData.price,
      data,
      setDate,
    );

    warehouseNotifier.updateWarehouse(
      warehouseData.warehouseId!,
      warehouseData.size,
      warehouseData.price,
      warehouseData.humiditySensorId,
      warehouseData.description,
      warehouseData.containerStorageId,
      1,
      warehouseData.warehouseId!,
    );
    final message = context.getString('rent.message.successful.rent');
    CustomSnackBar.snackBarOk(StringConstants.title, message, context);
  }
}

class _DateRent extends StatefulWidget {
  const _DateRent({Key? key}) : super(key: key);

  @override
  State<_DateRent> createState() => _DateRentState();
}

class _DateRentState extends State<_DateRent> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      calendarStyle: const CalendarStyle(
        holidayTextStyle: TextStyle(color: Colors.tealAccent),
        selectedTextStyle: TextStyle(
          color: Colors.tealAccent,
        ),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        setState(
          () {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            final rentNotifier = context.read<RentNotifier>();
            rentNotifier.setData(selectedDay);
          },
        );
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }
}

class _DropdownItemState extends StatefulWidget {
  @override
  State<_DropdownItemState> createState() => _DropdownItemStateState();
}

class _DropdownItemStateState extends State<_DropdownItemState> {
  String? selectedValue;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier =
          Provider.of<NumWarehouseNotifier>(context, listen: false);
      notifier.getWarehouses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<NumWarehouseNotifier>(context);
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
            items: notifier.warehouseList?.map((item) {
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
      final warehouseNotifier = context.read<NumWarehouseNotifier>();
      warehouseNotifier.getWarehouseOnId(
        int.parse(newValue),
      );
    });
  }
}
