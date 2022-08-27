import 'package:small_warehouse/rent/domain/entities/rent.dart';

abstract class RentRepository {
  Stream<Rent> get rentStream;

  Future<void> rentWarehouse(Rent dataRent);
}
