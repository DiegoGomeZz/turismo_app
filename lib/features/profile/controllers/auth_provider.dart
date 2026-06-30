import 'package:flutter/material.dart';
import '../enums/auth_state.dart';
import '../models/user_model.dart';
import '../services/api_client.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {

  late final AuthService _authService;

  AuthState _authState =
      AuthState.loading;

  UserModel? _user;

  String? _token;

  AuthState get authState =>
      _authState;

  UserModel? get user => _user;

  bool get isLoggedIn =>
      _authState ==
      AuthState.authenticated;

  AuthProvider() {

    final apiClient = ApiClient(
      baseUrl: 'https://p01--turismo-app-back--rzjxhlb42yvn.code.run',
    );

    _authService = AuthService(
      apiClient,
    );

    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    _authState =
        AuthState.unauthenticated;
    notifyListeners();
  }

  Future<bool> login(
    String email,
    String password,
  ) async {
    try {
      _authState =
          AuthState.loading;
      notifyListeners();
      final response =
          await _authService.login(
        email,
        password,
      );
      _user = response.user;
      _token = response.token;
      _authState =
          AuthState.authenticated;
      return true;

    } catch (e) {
      debugPrint(e.toString());
      _authState =
          AuthState.unauthenticated;
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
      _authState =
          AuthState.loading;

      notifyListeners();

      final response =
          await _authService.register(
        name: name,
        lastname: lastname,
        email: email,
        phone: phone,
        password: password,
      );

      _user = response.user;
      _token = response.token;
      _authState =
          AuthState.authenticated;
      return true;

    } catch (e) {
      debugPrint(e.toString());
      _authState =
          AuthState.unauthenticated;
      return false;
    } finally {
      notifyListeners();
    }
  }

  void logout() {
    _user = null;
    _token = null;
    _authState = AuthState.unauthenticated;
    notifyListeners();
  }
}