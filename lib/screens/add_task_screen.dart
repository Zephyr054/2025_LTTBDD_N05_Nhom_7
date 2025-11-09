import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:get/get.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(Task) onAdd;

  const AddTaskScreen({super.key, required this.onAdd});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _status = 'notStarted'.tr;
  DateTime _deadline = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('addTaskTitle'.tr)),
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
                Text(
                  'addNewTask'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _titleCtrl,
                  decoration: InputDecoration(
                    labelText: 'taskTitle'.tr,
                    prefixIcon: const Icon(Icons.title),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _descCtrl,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'taskDesc'.tr,
                    prefixIcon: const Icon(Icons.description),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _status,
                  items: [
                    DropdownMenuItem(
                      value: 'notStarted'.tr,
                      child: Text('notStarted'.tr),
                    ),
                    DropdownMenuItem(
                      value: 'inProgress'.tr,
                      child: Text('inProgress'.tr),
                    ),
                    DropdownMenuItem(
                      value: 'completed'.tr,
                      child: Text('completed'.tr),
                    ),
                  ],
                  onChanged: (val) => setState(() => _status = val!),
                  decoration: InputDecoration(
                    labelText: 'status'.tr,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    '${'deadline'.tr}: ${_deadline.toString().split(' ')[0]}',
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
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: Text(
                      'saveTask'.tr,
                      style: const TextStyle(fontSize: 18),
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
                          SnackBar(content: Text('enterTitleWarn'.tr)),
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

                      widget.onAdd(newTask);
                      Navigator.pop(context);
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
