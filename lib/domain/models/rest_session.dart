class RestSession {
  final String taskName;
  final String message;
  final DateTime startedAt;
  final DateTime endsAt;

  const RestSession({
    required this.taskName,
    required this.message,
    required this.startedAt,
    required this.endsAt,
  });
}
