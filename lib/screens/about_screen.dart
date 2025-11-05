import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giới thiệu')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Ứng dụng Quản lý công việc cá nhân\n'
            'Sinh viên: Nguyễn Tấn Dũng\n'
            'Lớp: Lập trình thiết bị di động- N05\n'
            'Trường: Đại học Phenikaa\n'
            'Năm học: 2025',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
