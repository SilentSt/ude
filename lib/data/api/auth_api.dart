import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ude/data/api/api_strings.dart';
import 'package:ude/data/api/headers.dart';
import 'package:ude/data/models/user.dart';

class AuthApi {
  static Future<http.Response> auth(Auth auth) async {
    return await http.post(
      Uri.parse(ApiStrings.api + ApiStrings.login),
      body: json.encode(auth.toJson()),
      headers: Headers.post,
    );
  }

  static Future<http.Response> createUser(CreateUser createUser) async {
    return await http.post(
      Uri.parse(ApiStrings.api + ApiStrings.registrate),
      body: json.encode(createUser.toJson()),
      headers: Headers.post,
    );
  }
}
