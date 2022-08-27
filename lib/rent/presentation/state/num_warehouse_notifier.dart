import 'dart:async';

import 'package:flutter/material.dart';
import 'package:small_warehouse/common/utils/custom_exception.dart';
import 'package:small_warehouse/rent/domain/entities/num_warehouses.dart';
import 'package:small_warehouse/rent/domain/repositories/num_warehouse_repository.dart';

class NumWarehouseNotifier extends ChangeNotifier {
  final NumWarehouseRepository _repository;

  NumWarehouseNotifier(this._repository) {
    _repository.warehousesStream.listen(
      (event) {
        warehouseList = event;
        notifyListeners();
      },
    );
  }

  NumWarehouses? _warehouses;

  NumWarehouses? get currentWarehouses => _warehouses;

  List<NumWarehouses>? warehouseList;

  late StreamSubscription _numWarehousesSubscription;

  var _numWarehousesException = CustomException(null);

  CustomException get authException => _numWarehousesException;

  Future<void> getWarehouses() async {
    _handleCustomError(null);
    notifyListeners();
    try {
      _repository.getWarehouses();
    } on CustomResponseException catch (e) {
      _handleCustomError(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> getWarehouseOnId(int id) async {
    _handleCustomError(null);
    notifyListeners();
    try {
      final dataWarehouse = await _repository.getWarehouseOnId(id);
      _warehouses = dataWarehouse;
    } on CustomResponseException catch (e) {
      _handleCustomError(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateWarehouse(
    int warehouseId,
    int size,
    int price,
    int humiditySensorId,
    String description,
    int containerStorageId,
    int isRented,
    int id,
  ) async {
    _handleCustomError(null);
    notifyListeners();
    try {
      await _repository.updateWarehouse(
          NumWarehouses(
            warehouseId,
            size,
            price,
            humiditySensorId,
            description,
            containerStorageId,
            isRented,
          ),
          id);
    } on CustomResponseException catch (e) {
      _handleCustomError(e);
    } finally {
      notifyListeners();
    }
  }

  void _handleCustomError(Exception? exception) {
    _numWarehousesException = CustomException(exception);
  }

  @override
  void dispose() {
    _numWarehousesSubscription.cancel();
    super.dispose();
  }
}
