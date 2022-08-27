import 'package:small_warehouse/rent/utils/rent_exception.dart';

class RentFetchFailed extends RentException {
  RentFetchFailed({String? description}) : super(description: description);
}
