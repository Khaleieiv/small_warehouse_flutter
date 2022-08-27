import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:small_warehouse/common/config/path_api.dart';
import 'package:small_warehouse/common/utils/http_response_utils.dart';
import 'package:small_warehouse/rent/domain/entities/num_warehouses.dart';
import 'package:small_warehouse/rent/domain/repositories/num_warehouse_repository.dart';
import 'package:small_warehouse/rent/utils/num_warehouses_fetch_failed.dart';

class ListNumWarehousesRepository extends NumWarehouseRepository {
  static const _getWarehousesPath = 'api/Warehouse/CheckRented';
  static const _getWarehouseOnId = 'api/Warehouse/GetWarehouseOnId';
  static const _updateWarehouse = 'api/Warehouse';

  final _client = http.Client();

  final _numWarehouseController = StreamController<List<NumWarehouses>>();

  @override
  Stream<List<NumWarehouses>> get warehousesStream =>
      _numWarehouseController.stream;

  @override
  Future<void> getWarehouses() async {
    final requestUri = Uri.http(Api.baseUrl, _getWarehousesPath);
    final response = await _client.get(requestUri, headers: Api.headers);
    _processGetWarehousesResponse(response);
  }

  @override
  Future<NumWarehouses?> getWarehouseOnId(int id) async {
    final params = {
      'id': id,
    };
    final requestUri = Uri.http(Api.baseUrl, _getWarehouseOnId);
    final response = await _client.post(
      requestUri,
      headers: Api.headers,
      body: jsonEncode(params),
    );
    return _processGetWarehouseOnIdResponse(response);
  }

  @override
  Future<void> updateWarehouse(NumWarehouses numWarehouses, int id) async {
    final requestBody = numWarehouses.toMap();
    final path = '$_updateWarehouse/$id';
    final requestUri = Uri.http(Api.baseUrl, path,);
    final response = await _client.put(
      requestUri,
      headers: Api.headers,
      body: jsonEncode(requestBody),
    );
    _processUpdateWarehouseResponse(response);
  }

  void _processGetWarehousesResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      _processGetWarehousesResponseOk(response);
    } else {
      _processWarehouseResponseFailed(response);
    }
  }

  NumWarehouses? _processGetWarehouseOnIdResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
     return _processGetWarehouseOnIdResponseOK(response);
    } else {
      _processWarehouseResponseFailed(response);
      return null;
    }
  }

  void _processUpdateWarehouseResponse(http.Response response) {
    if (response.statusCode != HttpStatus.ok) {
      _processWarehouseResponseFailed(response);
    }
  }

  void _processGetWarehousesResponseOk(http.Response response) {
    final decodedResponse = HttpResponseUtils.parseHttpResponseAsList(response);
    final warehouses =
        decodedResponse.map((row) => NumWarehouses.fromJson(row)).toList();
    _numWarehouseController.sink.add(warehouses);
  }

  NumWarehouses _processGetWarehouseOnIdResponseOK(http.Response response) {
    final decodedResponse = HttpResponseUtils.parseHttpResponse(response);
    final warehouse = NumWarehouses.fromJson(decodedResponse);
    return warehouse;
  }

  void _processWarehouseResponseFailed(http.Response response) {
    throw NumWarehouseFetchFailed(description: utf8.decode(response.bodyBytes));
  }
}
