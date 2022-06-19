class AppError {
  final String errors;

  AppError.fromJson(Map<String, dynamic> data)
      : errors = data['errors'].join('\n');
}
