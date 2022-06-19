import 'package:elementary/elementary.dart';
import 'package:ude/domain/auth_service.dart';

class AuthScreenModel extends ElementaryModel {
  final AuthService authService;

  AuthScreenModel({
    this.authService = const AuthService(),
  });
}
