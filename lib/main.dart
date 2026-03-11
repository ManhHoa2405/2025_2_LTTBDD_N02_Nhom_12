import 'package:flutter/material.dart';
import 'home_page.dart';
import 'info_page.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrangChu(),
    ),
  );
}

class TrangChu extends StatefulWidget {
  const TrangChu({super.key});

  @override
  State<TrangChu> createState() => _TrangChuState();
}

class _TrangChuState extends State<TrangChu> {
  var stt = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: stt,
          children: const [
            HomePage(),
            InfoPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: stt,
        selectedItemColor: stt == 0 ? Colors.yellow : Colors.yellow,
        unselectedItemColor: Colors.grey,
        onTap: (i) {
          setState(() {
            stt = i;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ (home)',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Thông tin (info)',
          ),
        ],
      ),
    );
  }
}