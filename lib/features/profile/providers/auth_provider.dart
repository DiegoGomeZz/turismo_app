import 'package:flutter/material.dart';
import '../enums/auth_state.dart';
import '../models/user_model.dart';
import '../services/api_client.dart';
import '../services/auth_service.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late final AuthService _authService;

  AuthState _authState = AuthState.loading;

  UserModel? _user;

  String? _token;

  AuthState get authState => _authState;

  UserModel? get user => _user;

  bool get isLoggedIn => _authState == AuthState.authenticated;

  AuthProvider() {
    final apiClient = ApiClient(
      baseUrl: 'https://p01--turismo-app-back--rzjxhlb42yvn.code.run',
    );

    _authService = AuthService(apiClient);

    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userJson = prefs.getString('user');

    if (token != null && userJson != null) {
      _token = token;
      _user = UserModel.fromJson(jsonDecode(userJson));
      _authState = AuthState.authenticated;
    } else {
      _authState = AuthState.unauthenticated;
    }

    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    try {
      _authState = AuthState.loading;
      notifyListeners();
      final response = await _authService.login(email, password);
      _user = response.user;
      _token = response.token;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('user', jsonEncode(_user!.toJson()));

      _authState = AuthState.authenticated;
      return true;
    } catch (e) {
      debugPrint(e.toString());
      _authState = AuthState.unauthenticated;
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> register({
    required String name,
    required String lastname,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      _authState = AuthState.loading;

      notifyListeners();

      final response = await _authService.register(
        name: name,
        lastname: lastname,
        email: email,
        phone: phone,
        password: password,
      );

      _user = response.user;
      _token = response.token;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('user', jsonEncode(_user!.toJson()));

      _authState = AuthState.authenticated;
      return true;
    } catch (e) {
      debugPrint(e.toString());
      _authState = AuthState.unauthenticated;
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateUser({
    String? name,
    String? lastname,
    String? phone,
  }) async {
    if (_user == null) {
      throw Exception('Usuario no autenticado');
    }
    try {
      _authState = AuthState.loading;
      notifyListeners();
      final updatedUser = await _authService.updateUser(
        id: _user!.id,
        token: _token!,
        name: name,
        lastname: lastname,
        phone: phone,
      );

      _user = updatedUser;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(_user!.toJson()));

      _authState = AuthState.authenticated;
    } catch (e) {
      _authState = AuthState.authenticated;
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _user = null;
    _token = null;

    _authState = AuthState.unauthenticated;
    notifyListeners();
  }
}
