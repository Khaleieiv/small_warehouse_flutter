import 'package:small_warehouse/rent/domain/entities/num_warehouses.dart';

abstract class NumWarehouseRepository {
  Stream<List<NumWarehouses>> get warehousesStream;

  void getWarehouses();
}