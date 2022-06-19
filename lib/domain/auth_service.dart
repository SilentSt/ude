import 'dart:convert';

import 'package:ude/data/api/auth_api.dart';
import 'package:ude/data/local_storage/user_storage.dart';
import 'package:ude/data/models/error.dart';
import 'package:ude/data/models/user.dart';

class AuthService {
  const AuthService();

  Future<bool> login({
    required String login,
    required String password,
  }) async {
    final res = await AuthApi.auth(Auth(
      email: login,
      password: password,
    ));
    final Map<String, dynamic> data = json.decode(res.body);
    if (res.statusCode > 299) {
      UserStorage.errors.add(
        AppError.fromJson(
          data,
        ),
      );
      return false;
    }
    UserStorage.userToken = Token.fromJson(
      data,
    );
    return true;
  }

  Future<bool> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await AuthApi.createUser(
      CreateUser(
        email: email,
        password: password,
        name: name,
      ),
    );
    final Map<String, dynamic> data = json.decode(res.body);
    if (res.statusCode > 299) {
      UserStorage.errors.add(
        AppError.fromJson(
          data,
        ),
      );
      return false;
    }
    return true;
  }
}
