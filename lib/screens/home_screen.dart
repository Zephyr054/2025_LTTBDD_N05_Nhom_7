import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:get/get.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;
  final Function(Task) onUpdate;

  const EditTaskScreen({super.key, required this.task, required this.onUpdate});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;
  late String _status;
  late DateTime _deadline;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.task.title);
    _descCtrl = TextEditingController(text: widget.task.description);
    _status = widget.task.status;
    _deadline = widget.task.deadline;
  }

  void _saveChanges() {
    final updatedTask = Task(
      id: widget.task.id,
      title: _titleCtrl.text,
      description: _descCtrl.text,
      status: _status,
      deadline: _deadline,
    );

    widget.onUpdate(updatedTask);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('editTaskTitle'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: InputDecoration(labelText: 'taskTitle'.tr),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descCtrl,
              decoration: InputDecoration(labelText: 'taskDesc'.tr),
            ),
            const SizedBox(height: 8),
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
              decoration: InputDecoration(labelText: 'status'.tr),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${'deadline'.tr}: ${_deadline.toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _deadline,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() => _deadline = pickedDate);
                    }
                  },
                  child: Text('editDeadline'.tr),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: Text('saveChanges'.tr),
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
