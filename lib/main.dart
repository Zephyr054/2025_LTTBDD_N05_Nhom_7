import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/state_manager.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/settings_screen.dart';
import 'translations.dart';
import 'package:get/get.dart';

void main() {
  runApp(const StudyPlannerApp());
}

class StudyPlannerApp extends StatefulWidget {
  const StudyPlannerApp({super.key});

  @override
  State<StudyPlannerApp> createState() => _StudyPlannerAppState();
}

class _StudyPlannerAppState extends State<StudyPlannerApp> {
  bool _isDarkMode = false;
  String _language = 'vi';
  String _username = 'Người dùng';
  Color _seedColor = Colors.indigo;
  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: brightness,
      ),
      useMaterial3: true,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF9FAFB),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : _seedColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: _language == 'vi'
          ? const Locale('vi', 'VN')
          : const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      title: 'Task Manager',
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),

      home: MainPage(
        isDarkMode: _isDarkMode,
        language: _language,
        username: _username,
        onThemeChanged: (val) => setState(() => _isDarkMode = val),
        onLanguageChanged: (val) {
          setState(() => _language = val);
          Get.updateLocale(
            val == 'vi' ? const Locale('vi', 'VN') : const Locale('en', 'US'),
          );
        },
        onUsernameChanged: (val) => setState(() => _username = val),
        seedColor: _seedColor,
        onColorChanged: (color) => setState(() => _seedColor = color),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final String username;
  final Function(bool) onThemeChanged;
  final Function(String) onLanguageChanged;
  final Function(String) onUsernameChanged;
  final Color seedColor;
  final Function(Color) onColorChanged;

  const MainPage({
    super.key,
    required this.isDarkMode,
    required this.language,
    required this.username,
    required this.onThemeChanged,
    required this.onLanguageChanged,
    required this.onUsernameChanged,
    required this.seedColor,
    required this.onColorChanged,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<Widget> get _pages => [
    const HomeScreen(),
    const AboutScreen(),
    SettingsScreen(
      isDarkMode: widget.isDarkMode,
      currentLanguage: widget.language,
      username: widget.username,
      onThemeChanged: widget.onThemeChanged,
      onLanguageChanged: widget.onLanguageChanged,
      onUsernameChanged: widget.onUsernameChanged,
      onResetData: _resetData,
      seedColor: widget.seedColor,
      onColorChanged: widget.onColorChanged,
    ),
  ];

  void _resetData() {
    // ⚙️ sau này có thể reset danh sách Task nếu muốn
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã đặt lại dữ liệu')));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const AboutScreen(),
      SettingsScreen(
        isDarkMode: widget.isDarkMode,
        currentLanguage: widget.language,
        username: widget.username,
        onThemeChanged: widget.onThemeChanged,
        onLanguageChanged: widget.onLanguageChanged,
        onUsernameChanged: widget.onUsernameChanged,
        onResetData: _resetData,
        seedColor: widget.seedColor,
        onColorChanged: widget.onColorChanged,
      ),
    ];
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'homeTitle'.tr,
          ),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'about'.tr),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settingsTitle'.tr,
          ),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
