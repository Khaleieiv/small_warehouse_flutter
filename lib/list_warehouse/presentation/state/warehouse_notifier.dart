import 'dart:async';

import 'package:flutter/material.dart';
import 'package:small_warehouse/common/utils/custom_exception.dart';
import 'package:small_warehouse/list_warehouse/domain/repositories/warehouse_repository.dart';

class WarehouseNotifier extends ChangeNotifier {

  final WarehouseRepository _repository;

  WarehouseNotifier(this._repository);

  late StreamSubscription _warehouseSubscription;

  var _authException = CustomException(null);
  CustomException get authException => _authException;

  Future<void> listWarehouseOnHumidity(String humidityStart,
      String humidityEnd) async {
    _handleCustomError(null);
    notifyListeners();
    try{
      _repository.humidityWarehouse(humidityStart, humidityEnd);
    }on CustomResponseException catch (e) {
      _handleCustomError(e);
    } finally {
      notifyListeners();
    }
  }

  void _handleCustomError(Exception? exception) {
    _authException = CustomException(exception);
  }

  @override
  void dispose() {
    _warehouseSubscription.cancel();
    super.dispose();
  }
}
