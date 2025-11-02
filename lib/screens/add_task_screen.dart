import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(Task) onAdd;

  const AddTaskScreen({super.key, required this.onAdd});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _status = 'Chưa làm';
  DateTime _deadline = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm công việc')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: 'Tiêu đề'),
            ),
            TextField(
              controller: _descCtrl,
              decoration: const InputDecoration(labelText: 'Mô tả'),
            ),
            DropdownButton<String>(
              value: _status,
              items: [
                'Chưa làm',
                'Đang làm',
                'Hoàn thành',
              ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) => setState(() => _status = val!),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onAdd(
                  Task(
                    title: _titleCtrl.text,
                    description: _descCtrl.text,
                    status: _status,
                    deadline: _deadline,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Lưu công việc'),
            ),
          ],
        ),
      ),
    );
  }
}
