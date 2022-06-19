import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ude/data/api/api_strings.dart';
import 'package:ude/data/models/code.dart';

import 'headers.dart';

class CodeApi {

  static Future<http.Response> sendFile(File file) async {
    return await http.post(
      Uri.parse(ApiStrings.api + ApiStrings.sendFile),
      body: json.encode(file.toJson()),
      headers: Headers.postAuthed,
    );
  }

  static Future<http.Response> getFiles() async {
    return await http.get(
      Uri.parse(ApiStrings.api + ApiStrings.sendFile),
      headers: Headers.getAuthed,
    );
  }

  static Future<http.Response> compile(Compile compile) async {
    return await http.post(
      Uri.parse(ApiStrings.api + ApiStrings.compileLng),
      body: json.encode(compile.toJson()),
      headers: Headers.postAuthed,
    );
  }
}
