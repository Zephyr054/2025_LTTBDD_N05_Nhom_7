import 'package:flutter/material.dart';
import '../models/task.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [
    Task(
      id: '1',
      title: 'Ôn thi cuối kì Bảo mật ứng dụng và hệ thống',
      description: 'Chương 1 đến chương 9',
      status: 'Hoàn thành',
      deadline: DateTime(2025, 11, 4),
    ),
  ];

  void _addTask(Task newTask) {
    setState(() {
      tasks.add(newTask);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã thêm công việc mới!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Study Planner')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final t = tasks[index];
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                tasks.removeAt(index);
              });
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Đã xóa công việc')));
            },
            child: Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(t.title),
                subtitle: Text(
                  '${t.description}\nTrạng thái: ${t.status}\nHạn: ${t.deadline.toString().split(' ')[0]}',
                ),
                isThreeLine: true,
                onTap: () async {
                  // Mở trang sửa khi nhấn vào
                  final updatedTask = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskScreen(
                        task: t,
                        onUpdate: (newTask) {
                          setState(() {
                            tasks[index] = newTask;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(onAdd: _addTask),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
