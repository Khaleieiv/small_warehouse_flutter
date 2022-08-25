import 'package:small_warehouse/list_warehouse/domain/entities/warehouse.dart';

abstract class WarehouseRepository {
  Stream<List<Warehouse>> get warehousesStream;

  void humidityWarehouse(
    int humidityStart,
    int humidityEnd,
  );
}
