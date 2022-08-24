import 'package:small_warehouse/list_warehouse/utils/warehouse_exception.dart';

class WarehouseFetchFailed extends WarehouseException {
  WarehouseFetchFailed({String? description}) : super(description: description);
}
