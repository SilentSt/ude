class File {
  final String name;
  final int lng;
  final String code;

  File({
    required this.name,
    required this.lng,
    required this.code,
  });

  File.fromJson(Map<String, dynamic> data)
      : name = data['fileName'],
        code = data['code'],
        lng = data['language'];

  Map<String, dynamic> toJson() => {
        'fileName': name,
        'code': code,
        'lnaguage': lng,
      };
}

class Result {
  final String data;

  Result.fromJson(Map<String, dynamic> data) : data = data['data'];
}

class Compile {
  final int lng;

  Compile({
    required this.lng,
  });

  Map<String, dynamic> toJson() => {
        'language': lng,
      };
}
