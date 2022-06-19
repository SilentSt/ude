import 'dart:convert';

import 'package:ude/data/api/code_api.dart';
import 'package:ude/data/local_storage/user_storage.dart';
import 'package:ude/data/models/code.dart';
import 'package:ude/data/models/error.dart';

class CodeService {
  const CodeService();
  Future<bool> sendFile({
    String name = 'main',
    int lng = 1,
    required String code,
  }) async {
    final file = File(name: name, lng: lng, code: code);
    final res = await CodeApi.sendFile(file);
    final Map<String, dynamic> data = json.decode(res.body);
    if (res.statusCode > 299) {      
      UserStorage.errors.add(
        AppError.fromJson(
          data,
        ),
      );
      return false;
    }
    await getFiles();
    return true;
  }

  Future<bool> getFiles() async {
    final res = await CodeApi.getFiles();
    final Map<String, dynamic> data = json.decode(res.body) as Map<String,dynamic>;
    if (res.statusCode > 299) {
      UserStorage.errors.add(
        
        AppError.fromJson(
          data,
        ),
      );
      return false;
    }
    final lst = List.generate(
      data['data'].length,
      (index) => File.fromJson(data['data'][index]),
    );
    UserStorage.files = lst;
    return true;
  }

  Future<bool> compile({int lng = 1}) async {
    final compile = Compile(lng: lng);
    final res = await CodeApi.compile(compile);
    final Map<String, dynamic> data = json.decode(res.body);
    if (res.statusCode > 299) {
      UserStorage.errors.add(
        AppError.fromJson(
          data,
        ),
      );
      return false;
    }
    UserStorage.results.add(
      Result.fromJson(
        data,
      ),
    );
    return true;
  }
}
