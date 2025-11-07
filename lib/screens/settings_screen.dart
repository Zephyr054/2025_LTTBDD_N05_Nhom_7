import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final Function(String) onLanguageChanged;
  final Function(String) onUsernameChanged;
  final Function() onResetData;
  final bool isDarkMode;
  final String currentLanguage;
  final String username;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.onLanguageChanged,
    required this.onUsernameChanged,
    required this.onResetData,
    required this.isDarkMode,
    required this.currentLanguage,
    required this.username,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isDarkMode;
  late String _language;
  late String _username;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _language = widget.currentLanguage;
    _username = widget.username;
  }

  // Hàm mở hộp thoại sửa tên
  void _editUsername() {
    TextEditingController ctrl = TextEditingController(text: _username);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Đổi tên người dùng'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(labelText: 'Nhập tên mới'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _username = ctrl.text.trim();
              });
              widget.onUsernameChanged(_username);
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  // Hàm xác nhận reset dữ liệu
  void _confirmReset() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa toàn bộ dữ liệu?'),
        content: const Text(
          'Thao tác này sẽ xóa tất cả công việc hiện có. Bạn có chắc chắn không?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              widget.onResetData();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã đặt lại toàn bộ dữ liệu')),
              );
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: ListView(
        children: [
          const SizedBox(height: 8),

          // 🌙 Bật/Tắt chế độ tối
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Chế độ tối'),
            value: _isDarkMode,
            onChanged: (val) {
              setState(() => _isDarkMode = val);
              widget.onThemeChanged(val);
            },
          ),

          // 🗣 Chuyển ngôn ngữ
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Ngôn ngữ'),
            trailing: DropdownButton<String>(
              value: _language,
              items: const [
                DropdownMenuItem(value: 'vi', child: Text('Tiếng Việt')),
                DropdownMenuItem(value: 'en', child: Text('English')),
              ],
              onChanged: (val) {
                if (val != null) {
                  setState(() => _language = val);
                  widget.onLanguageChanged(val);
                }
              },
            ),
          ),

          const Divider(),

          // 👤 Sửa tên người dùng
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Tên người dùng'),
            subtitle: Text(_username.isEmpty ? 'Chưa có tên' : _username),
            trailing: const Icon(Icons.edit),
            onTap: _editUsername,
          ),

          const Divider(),

          // 💾 Đặt lại dữ liệu
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text(
              'Đặt lại dữ liệu',
              style: TextStyle(color: Colors.red),
            ),
            onTap: _confirmReset,
          ),
        ],
      ),
    );
  }
}
