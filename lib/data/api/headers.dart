import 'package:ude/data/local_storage/user_storage.dart';

class Headers {
  static final Map<String, String> post = {
    //'accept': '*/*',
    'Content-Type': 'application/json',
  };

  static final Map<String, String> get = {
    //'accept': '*/*',
  };

  static final Map<String, String> postAuthed = {
    //'accept': '*/*',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${UserStorage.userToken.token}',
  };

  static final Map<String, String> getAuthed = {
    //'accept': '*/*',
    'Authorization': 'Bearer ${UserStorage.userToken.token}',
  };
}
