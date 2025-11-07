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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Thêm công việc mới',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _titleCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Tiêu đề',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _descCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Mô tả',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _status,
                  items: ['Chưa làm', 'Đang làm', 'Hoàn thành']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) => setState(() => _status = val!),
                  decoration: const InputDecoration(
                    labelText: 'Trạng thái',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    'Hạn: ${_deadline.toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _deadline,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() => _deadline = pickedDate);
                    }
                  },
                ),
                const SizedBox(height: 20),
                //Nút thêm công việc mới
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text(
                      'Thêm công việc',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_titleCtrl.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Vui lòng nhập tiêu đề'),
                          ),
                        );
                        return;
                      }

                      final newTask = Task(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: _titleCtrl.text,
                        description: _descCtrl.text,
                        status: _status,
                        deadline: _deadline,
                      );

                      widget.onAdd(newTask); // Gửi task về trang chính
                      Navigator.pop(context); // Quay lại trang trước
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

