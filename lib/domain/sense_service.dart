import 'dart:convert';

import 'package:ude/data/api/sense_api.dart';
import 'package:ude/data/local_storage/user_storage.dart';
import 'package:ude/data/models/error.dart';
import 'package:ude/data/models/sense.dart';

class SenseService {
  const SenseService();

  Future<bool> saveSense(String senseString) async {
    final sense = UserStorage.sense;
    sense.sense.add(senseString);
    final res = await SenseApi.sendSense(sense);
    if (res.statusCode > 299) {
      final Map<String, dynamic> data = json.decode(res.body);
      UserStorage.errors.add(AppError.fromJson(data));
      return false;
    }
    await getSense();
    return true;
  }

  Future<bool> removeSense(int index) async {
    UserStorage.sense.sense.removeAt(index);
    final res = await SenseApi.sendSense(UserStorage.sense);    
    if (res.statusCode > 299) {
      final Map<String, dynamic> data = json.decode(res.body);
      UserStorage.errors.add(AppError.fromJson(data));
      return false;
    }
    await getSense();
    return true;
  }

  Future<bool> getSense() async {
    final res = await SenseApi.getSense();
    final Map<String, dynamic> data = json.decode(res.body);
    if (res.statusCode > 299) {
      UserStorage.errors.add(AppError.fromJson(data));
      return false;
    }
    UserStorage.sense = Sense.fromJson(data);
    UserStorage.sense.sense.sort(
      (a, b) => a.compareTo(b),
    );
    return true;
  }
}
