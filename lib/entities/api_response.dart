class ApiResponse {
  int status;
  String message;
  dynamic data;

  ApiResponse({
    required this.message,
    required this.data,
    required this.status,
  });
}
