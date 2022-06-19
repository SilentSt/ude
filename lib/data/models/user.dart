class Auth {
  final String email;
  final String password;

  Auth({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class Token {
  final String token;
  final String refreshToken;

  Token.fromJson(Map<String, dynamic> data)
      : token = data['token'],
        refreshToken = data['refreshToken'];
}

class CreateUser {
  final String email;
  final String password;
  final String name;

  CreateUser({
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
      };
}
