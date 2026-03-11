import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin / Info'),
      ),
      body: const Center(
        child: Text('Thông tin của Nguyễn Đình Đạt sẽ hiển thị ở đây.'),
      ),
    );
  }
}