import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ / Home'),
      ),
      body: const Center(
        child: Text('Giao diện Trang chủ sẽ được thiết kế ở đây.'),
      ),
    );
  }
}