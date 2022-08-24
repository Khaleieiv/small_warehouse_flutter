import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:small_warehouse/common/config/path_api.dart';
import 'package:small_warehouse/common/utils/http_response_utils.dart';
import 'package:small_warehouse/list_warehouse/domain/entities/warehouse.dart';
import 'package:small_warehouse/list_warehouse/domain/repositories/warehouse_repository.dart';
import 'package:http/http.dart' as http;
import 'package:small_warehouse/list_warehouse/utils/warehouse_fetch_failed.dart';

class WarehouseListRepository extends WarehouseRepository {
  static const _loginPath = 'api/Warehouse/Humidity';

  final _client = http.Client();
  final _warehouseController = StreamController<List<Warehouse>?>();

  @override
  void humidityWarehouse(String humidityStart, String humidityEnd) async {
    final headers = {
      'Content-type': 'application/json',
    };

    final paramsForPath = '$_loginPath/$humidityStart/$humidityEnd';
    final requestUri = Uri.http(Api.baseUrl, paramsForPath);
    print(requestUri);
    final response = await _client.get(requestUri, headers: headers);
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
        Warehouse.fromJson(row)).toList();
    _warehouseController.sink.add(warehouse);
  }

  void _processWarehouseResponseFailed(http.Response response) {
    throw WarehouseFetchFailed(description: utf8.decode(response.bodyBytes));
  }

}