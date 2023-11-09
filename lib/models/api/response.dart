enum RequestStatus { success, failed, unauthorized }

class ApiResponse {
  final Map<String, dynamic> data;
  final RequestStatus status;
  ApiResponse({
    required this.data,
    required this.status,
  });
}
