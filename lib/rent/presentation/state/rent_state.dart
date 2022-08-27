import 'dart:async';

import 'package:flutter/material.dart';
import 'package:small_warehouse/common/utils/custom_exception.dart';
import 'package:small_warehouse/rent/domain/entities/rent.dart';
import 'package:small_warehouse/rent/domain/repositories/rent_repository.dart';

class RentNotifier extends ChangeNotifier {
  final RentRepository _rentRepository;

  RentNotifier(this._rentRepository);

  late StreamSubscription _rentSubscription;

  var _rentException = CustomException(null);

  CustomException get rentException => _rentException;

  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;

  void setData(DateTime dateTime){
    _dateTime = dateTime;
    notifyListeners();
  }

  Future<void> rentWarehouse(
    String userName,
    String userPhone,
    String userEmail,
    int warehouseSize,
    int warehousePrice,
    DateTime dateStart,
    DateTime dateFinish,
  ) async {
    _handleRentError(null);
    notifyListeners();
    try {
     await _rentRepository.rentWarehouse(
        Rent(
          userName,
          userPhone,
          userEmail,
          warehouseSize,
          warehousePrice,
          dateStart,
          dateFinish,
        ),
      );
    } on CustomResponseException catch (e) {
      _handleRentError(e);
    } finally {
      notifyListeners();
    }
  }

  void _handleRentError(Exception? exception) {
    _rentException = CustomException(exception);
  }

  @override
  void dispose() {
    _rentSubscription.cancel();
    super.dispose();
  }
}
