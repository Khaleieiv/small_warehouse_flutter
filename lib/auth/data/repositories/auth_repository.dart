import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:small_warehouse/auth/domain/entities/user.dart';
import 'package:small_warehouse/auth/domain/repositories/user_repository.dart';
import 'package:small_warehouse/common/utils/custom_exception.dart';
import 'package:small_warehouse/common/config/path_api.dart';
import 'package:http/http.dart' as http;
import 'package:small_warehouse/common/utils/http_response_utils.dart';

class AuthRepository extends UserRepository {
  static const _loginPath = '/api/User/Authorization';
  static const _registerPath = '/api/User/Registration';
  static const _updateUserPath = '/api/User';

  final _client = http.Client();

  final _currentUserController = StreamController<User?>();

  @override
  Stream<User?> get currentUser => _currentUserController.stream;

  @override
  Future<void> registerUser(User userData) async {
    final requestBody = userData.toMap();
    final requestUri = Uri.http(Api.baseUrl, _registerPath);
    final response = await _client.post(requestUri, headers: Api.headers, body: jsonEncode(requestBody));
    _processRegisterResponse(response);
  }

  @override
  Future<void> loginUser(String email, String password) async {
      final params = {
        'email': email,
        'password': password,
      };
      final requestUri = Uri.http(Api.baseUrl, _loginPath);
      final response = await _client.post(requestUri, headers: Api.headers, body: jsonEncode(params));
      _processLoginResponse(response);
  }

  @override
  Future<void> updateProfile(User userData) async {
    final requestBody = userData.toMap();
    final id = userData.userId;
    final path = '$_updateUserPath/$id';
    final requestUri = Uri.http(Api.baseUrl, path);
    final response = await _client.put(requestUri, headers: Api.headers, body: jsonEncode(requestBody));
    _processUpdateProfileResponse(response);
    loginUser(userData.email, userData.password);
  }

  void _processUpdateProfileResponse(http.Response response) {
    if (response.statusCode != HttpStatus.ok) {
      _processStatusCodeFailed(response);
    }
  }

  void _processLoginResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      _processLoginResponseOk(response);
    } else {
      _processStatusCodeFailed(response);
    }
  }

  void _processRegisterResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      _processRegisterResponseOK(response);
    } else {
      _processStatusCodeFailed(response);
    }
  }

  void _processLoginResponseOk(http.Response response) {
    final decodedResponse = HttpResponseUtils.parseHttpResponse(response);
    final user = User.fromJson(decodedResponse);
    _currentUserController.sink.add(user);
  }

  void _processRegisterResponseOK(http.Response response) {
    final decodedResponse = HttpResponseUtils.parseHttpResponse(response);
    final user = User.fromJson(decodedResponse);
    _currentUserController.sink.add(user);
  }

  void _processStatusCodeFailed(http.Response response) {
    final bodyMap = HttpResponseUtils.parseHttpResponse(response);
    final parsedReason = bodyMap['message'];
    throw CustomResponseException(parsedReason ?? response.statusCode.toString());
  }
}
