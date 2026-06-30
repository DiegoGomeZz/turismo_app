import '../models/auth_response.dart';
import 'api_client.dart';
import '../models/user_model.dart';

/// Service responsible for handling authentication-related operations.
class AuthService {
  final ApiClient apiClient;

  AuthService(this.apiClient);

  Future<AuthResponse> login(String email, String password) async {
    final response = await apiClient.post('/auth/login/', {
      'email': email,
      'password': password,
    });

    if (response['success']) {
      return AuthResponse.fromJson(response['data']);
    }

    throw Exception(response['message']);
  }

  Future<AuthResponse> register({
    required String name,
    required String lastname,
    required String email,
    required String phone,
    required String password,
  }) async {
    final response = await apiClient.post('/auth/register/', {
      'name': name,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'password': password,
    });

    if (response['success']) {
      return AuthResponse.fromJson(response['data']);
    }

    throw Exception(response['message']);
  }

  Future<UserModel> updateUser({
    required int id,
    required String token,
    String? name,
    String? lastname,
    String? phone,
  }) async {
    final response = await apiClient.put('/auth/update/$id/', {
      'name': name,
      'lastname': lastname,
      'phone': phone,
    }, token: token);

    if (response['success']) {
      return UserModel.fromJson(response['data']['user']);
    }

    throw Exception(response['message']);
  }
}
