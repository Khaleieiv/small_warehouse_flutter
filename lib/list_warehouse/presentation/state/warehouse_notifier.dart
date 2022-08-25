import 'dart:async';

import 'package:flutter/material.dart';
import 'package:small_warehouse/common/utils/custom_exception.dart';
import 'package:small_warehouse/list_warehouse/domain/entities/list_humidity_for_drop_down_list.dart';
import 'package:small_warehouse/list_warehouse/domain/entities/warehouse.dart';
import 'package:small_warehouse/list_warehouse/domain/repositories/warehouse_repository.dart';

class WarehouseNotifier extends ChangeNotifier {
  final WarehouseRepository _repository;

  WarehouseNotifier(this._repository) {
    _repository.warehousesStream.listen(
      (event) {
        warehouseList = event;
        notifyListeners();
      },
    );
  }

  static const List<MyDropDownList> warehouses = [
    MyDropDownList(0, 100, 'All'),
    MyDropDownList(30, 40, 'Clothes'),
    MyDropDownList(35, 45, 'Technique'),
    MyDropDownList(40, 50, 'Flowers'),
    MyDropDownList(60, 70, 'Food'),
  ];

  List<Warehouse>? warehouseList;

  late StreamSubscription _warehouseSubscription;

  var _warehouseException = CustomException(null);

  CustomException get authException => _warehouseException;

  Future<void> listWarehouseOnHumidity(
    int humidityStart,
    int humidityEnd,
  ) async {
    _handleCustomError(null);
    notifyListeners();
    try {
      _repository.humidityWarehouse(humidityStart, humidityEnd);
    } on CustomResponseException catch (e) {
      _handleCustomError(e);
    } finally {
      notifyListeners();
    }
  }

  void _handleCustomError(Exception? exception) {
    _warehouseException = CustomException(exception);
  }

  @override
  void dispose() {
    _warehouseSubscription.cancel();
    super.dispose();
  }
}
