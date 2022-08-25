import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:small_warehouse/common/config/path_api.dart';
import 'package:small_warehouse/common/utils/http_response_utils.dart';
import 'package:small_warehouse/rent/domain/entities/num_warehouses.dart';
import 'package:small_warehouse/rent/domain/repositories/num_warehouse_repository.dart';
import 'package:http/http.dart' as http;
import 'package:small_warehouse/rent/utils/num_warehouses_fetch_failed.dart';

class ListNumWarehousesRepository extends NumWarehouseRepository {
  static const _getWarehousesPath = 'api/Warehouse';

  final _client = http.Client();

  final _numWarehouseController = StreamController<List<NumWarehouses>>();

  @override
  Stream<List<NumWarehouses>> get warehousesStream => _numWarehouseController.stream;

  @override
  Future<void> getWarehouses() async {
    final requestUri = Uri.http(Api.baseUrl, _getWarehousesPath);
    final response = await _client.get(requestUri, headers: Api.headers);
    _processLoginResponse(response);
  }

  void _processLoginResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      _processWarehouseResponseOk(response);
    } else {
      _processWarehouseResponseFailed(response);
    }
  }

  void _processWarehouseResponseOk(http.Response response) {
    final decodedResponse = HttpResponseUtils.parseHttpResponseAsList(response);
    final warehouse = decodedResponse.map((row) =>
        NumWarehouses.fromJson(row)).toList();
    _numWarehouseController.sink.add(warehouse);
  }

  void _processWarehouseResponseFailed(http.Response response) {
    throw NumWarehouseFetchFailed(description: utf8.decode(response.bodyBytes));
  }
}