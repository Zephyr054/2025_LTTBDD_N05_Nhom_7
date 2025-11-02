class Task {
  String title;
  String description;
  String status; // Chưa làm / Đang làm / Hoàn thành
  DateTime deadline;

  Task({
    required this.title,
    required this.description,
    required this.status,
    required this.deadline,
  });
}
