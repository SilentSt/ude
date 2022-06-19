import 'package:ude/data/models/code.dart';
import 'package:ude/data/models/error.dart';
import 'package:ude/data/models/sense.dart';
import 'package:ude/data/models/user.dart';

class UserStorage {
  static late Token userToken;
  static List<AppError> errors = [];
  static late Sense sense;
  static List<File> files = [];
  static List<Result> results = [];
}
