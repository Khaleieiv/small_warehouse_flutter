import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:small_warehouse/common/config/path_api.dart';
import 'package:small_warehouse/rent/domain/entities/rent.dart';
import 'package:small_warehouse/rent/domain/repositories/rent_repository.dart';
import 'package:http/http.dart' as http;
import 'package:small_warehouse/rent/utils/rent_fetch_failed.dart';

class RentWarehouseRepository extends RentRepository {
  static const _rentWarehouse = 'api/Rent';

  final _client = http.Client();

  final _rentController = StreamController<Rent>();

  @override
  Stream<Rent> get rentStream => _rentController.stream;

  @override
  Future<void> rentWarehouse(Rent dataRent) async {
    final requestBody = dataRent.toMap();
    final requestUri = Uri.http(Api.baseUrl, _rentWarehouse);
    final response = await _client.post(requestUri, headers: Api.headers, body: jsonEncode(requestBody));
    _processRentResponse(response);
  }

  void _processRentResponse(http.Response response) {
    if (response.statusCode != HttpStatus.ok) {
      _processRentResponseFailed(response);
    }
  }

  void _processRentResponseFailed(http.Response response) {
    throw RentFetchFailed(description: utf8.decode(response.bodyBytes));
  }
}
