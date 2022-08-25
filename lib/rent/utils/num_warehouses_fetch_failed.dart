import 'package:small_warehouse/rent/utils/num_warehouse_exception.dart';

class NumWarehouseFetchFailed extends NumWarehouseException {
  NumWarehouseFetchFailed({String? description}) : super(description: description);
}
