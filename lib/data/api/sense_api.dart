import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ude/data/models/sense.dart';

import 'api_strings.dart';
import 'headers.dart';

class SenseApi {
  static Future<http.Response> sendSense(Sense sense) async {
    return await http.post(
      Uri.parse(ApiStrings.api + ApiStrings.saveInteli),
      body: json.encode(sense.toJson()),
      headers: Headers.postAuthed,
    );
  }

  static Future<http.Response> getSense() async {
    return await http.get(
      Uri.parse(ApiStrings.api + ApiStrings.loadInteli),
      headers: Headers.getAuthed,
    );
  }
}
