import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_warehouse/common/widgets/row_for_text_and_drop_down.dart';
import 'package:small_warehouse/list_warehouse/domain/entities/list_humidity_for_drop_down_list.dart';
import 'package:small_warehouse/list_warehouse/presentation/state/warehouse_notifier.dart';

class ListWarehousePage extends StatefulWidget {
  const ListWarehousePage({Key? key}) : super(key: key);

  @override
  State<ListWarehousePage> createState() => _ListWarehousePageState();
}

class _ListWarehousePageState extends State<ListWarehousePage> {
  @override
  Widget build(BuildContext context) {
    final label = context.getString('list_warehouse.label');
    Widget dropdownItem = _DropdownItemState();
    final notifier = context.watch<WarehouseNotifier>();
    final warehouses = notifier.warehouseList;
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          RowForTextAndDropDownList(
            label,
            dropdownItem,
          ),
          const Spacer(),
          Text(
            context.getString('list_warehouse.list_warehouse'),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const Spacer(),
          if (warehouses != null)
            Expanded(
              flex: 4,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: warehouses.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: _ListWarehouseForBuilder(
                      warehouses[index].numWarehouse.toString(),
                      warehouses[index].size.toString(),
                      warehouses[index].price.toString(),
                      warehouses[index].humidity.toString(),
                      warehouses[index].description.toString(),
                    ),
                  );
                },
              ),
            ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _ListWarehouseForBuilder extends StatelessWidget {
  final String numWarehouse;
  final String sizeWarehouse;
  final String priceWarehouse;
  final String humidityWarehouse;
  final String descriptionWarehouse;

  const _ListWarehouseForBuilder(
    this.numWarehouse,
    this.sizeWarehouse,
    this.priceWarehouse,
    this.humidityWarehouse,
    this.descriptionWarehouse, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const pathImage = 'assets/images/warehouse_1.jpg';
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: ListTile(
            leading: Image.asset(
              pathImage,
              width: 50,
              height: 50,
            ),
            title: Text('№$numWarehouse'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text('${context.getString('list_warehouse.price')}  $priceWarehouse'),
                    const Spacer(),
                    Text('${context.getString('list_warehouse.size')}  $sizeWarehouse'),
                    const Spacer(),
                    Text('${context.getString('list_warehouse.humidity')}  $humidityWarehouse'),
                    const Spacer(),
                  ],
                ),
                Text('${context.getString('list_warehouse.description')}  $descriptionWarehouse'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DropdownItemState extends StatefulWidget {
  @override
  State<_DropdownItemState> createState() => _DropdownItemStateState();
}

class _DropdownItemStateState extends State<_DropdownItemState> {
  MyDropDownList? selectedValue = const MyDropDownList(0, 100, 'All');

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<MyDropDownList>> menuItems =
        WarehouseNotifier.warehouses.map((item) {
      return DropdownMenuItem(
        value: item,
        child: Text(item.name),
      );
    }).toList();

    return Form(
      child: Column(
        children: [
          DropdownButtonFormField<MyDropDownList>(
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
            items: menuItems,
          ),
        ],
      ),
    );
  }

  void _listWarehouseOnHumidity(MyDropDownList? newValue) {
    setState(() {
      selectedValue = newValue;
      if (newValue == null) return;
      final warehouseNotifier = context.read<WarehouseNotifier>();
      warehouseNotifier.listWarehouseOnHumidity(
        newValue.humidityMin,
        newValue.humidityMax,
      );
    });
  }
}
