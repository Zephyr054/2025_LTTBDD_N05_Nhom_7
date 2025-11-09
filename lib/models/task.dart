class Task {
  final String id;
  String title;
  String description;
  String status; // Chưa làm / Đang làm / Hoàn thành
  DateTime deadline;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.deadline,
  });
  // Chuyển đối tượng Task -> Map (để lưu JSON)
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'status': status,
    'deadline': deadline.toIso8601String(),
  };

  // Chuyển Map -> Task (để đọc lại)
  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    status: json['status'],
    deadline: DateTime.parse(json['deadline']),
  );
}
