import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final Function(String) onLanguageChanged;
  final Function(String) onUsernameChanged;
  final Function() onResetData;
  final bool isDarkMode;
  final String currentLanguage;
  final String username;
  final Color seedColor;
  final Function(Color) onColorChanged;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.onLanguageChanged,
    required this.onUsernameChanged,
    required this.onResetData,
    required this.isDarkMode,
    required this.currentLanguage,
    required this.username,
    required this.seedColor,
    required this.onColorChanged,
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
        title: Text('editUsername'.tr),
        content: TextField(
          controller: ctrl,
          decoration: InputDecoration(labelText: 'enterNewName'.tr),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _username = ctrl.text.trim();
              });
              widget.onUsernameChanged(_username);
              Navigator.pop(context);
            },
            child: Text('save'.tr),
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
        title: Text('resetDataTitle'.tr),
        content: Text('resetDataContent'.tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              widget.onResetData();
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('resetDataSnack'.tr)));
            },
            child: Text('delete'.tr),
          ),
        ],
      ),
    );
  }

  Widget _buildColorDot(Color color) {
    return GestureDetector(
      onTap: () {
        widget.onColorChanged(color);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã đổi sang màu ${colorString(color)}'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: color == widget.seedColor ? Colors.black : Colors.grey,
            width: color == widget.seedColor ? 2.5 : 1,
          ),
        ),
      ),
    );
  }

  String colorString(Color color) {
    if (color == Colors.indigo) return 'xanh dương';
    if (color == Colors.red) return 'đỏ';
    if (color == Colors.green) return 'xanh lá';
    if (color == Colors.orange) return 'cam';
    if (color == Colors.purple) return 'tím';
    return 'khác';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settingsTitle'.tr)),
      body: ListView(
        children: [
          const SizedBox(height: 8),

          // Bật/Tắt chế độ tối
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: Text('darkMode'.tr),
            value: _isDarkMode,
            onChanged: (val) {
              setState(() => _isDarkMode = val);
              widget.onThemeChanged(val);
            },
          ),

          // Chuyển ngôn ngữ
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('language'.tr),
            trailing: DropdownButton<String>(
              value: _language,
              items: [
                DropdownMenuItem(value: 'vi', child: Text('vietnamese'.tr)),
                DropdownMenuItem(value: 'en', child: Text('english'.tr)),
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
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Màu chủ đạo'),
            subtitle: Row(
              children: [
                _buildColorDot(Colors.indigo),
                _buildColorDot(Colors.red),
                _buildColorDot(Colors.green),
                _buildColorDot(Colors.orange),
                _buildColorDot(Colors.purple),
              ],
            ),
          ),

          const Divider(),

          //Sửa tên người dùng
          ListTile(
            leading: const Icon(Icons.person),
            title: Text('editUsername'.tr),
            subtitle: Text(_username.isEmpty ? 'Chưa có tên'.tr : _username),
            trailing: const Icon(Icons.edit),
            onTap: _editUsername,
          ),

          const Divider(),

          // 💾 Đặt lại dữ liệu
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: Text('ResetData'.tr, style: TextStyle(color: Colors.red)),
            onTap: _confirmReset,
          ),
        ],
      ),
    );
  }
}
