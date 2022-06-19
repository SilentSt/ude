class Sense {
  final List<String> sense;

  Sense({
    required this.sense,
  });

  Sense.fromJson(Map<String, dynamic> data)
      : sense = List.generate(
            data['data'].length, (index) => data['data'][index]);

  Map<String, dynamic> toJson() => {
        'intellis': sense,
      };
}
