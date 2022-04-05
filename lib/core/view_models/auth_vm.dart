// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../locator.dart';
import '../services/auth_service.dart';
import '../services/graphql_config.dart';
import '../storage/secure_storage.dart';
import 'base_vm.dart';

class AuthVM extends BaseModel {
  /// The auth access token key in storage.
  static const String ACCESS_TOKEN_KEY = 'access-token';
  final AuthService _auth = sl<AuthService>();
  final SecureStorage _storage = sl<SecureStorage>();
  final GraphQLConfiguration _graphQLConfig = sl<GraphQLConfiguration>();

  bool _loading = false;
  bool get getIsLoading => _loading;

  /// Requests a bool to indicate whether a user
  /// is logged in or not
  Future<bool> get isLoggedIn async {
    return null != (await _storage.read(ACCESS_TOKEN_KEY));
  }

  // Login
  Future<void> login({
    required String username,
    required String password,
  }) async {
    _loading = true;
    notifyListeners();

    try {
      String token = await _auth.login(username, password);
      debugPrint('TOKEN: $token');
      await _storage.write(ACCESS_TOKEN_KEY, token);
      Fluttertoast.showToast(
        msg: 'Login successful',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> logout() async {
    _loading = true;
    notifyListeners();

    return _storage.deleteAll().then((_) {
      _graphQLConfig.removeToken();
      Fluttertoast.showToast(
        msg: 'Logout successful',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14,
      );
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    }).whenComplete(() {
      _loading = false;
      notifyListeners();
    });
  }
}
