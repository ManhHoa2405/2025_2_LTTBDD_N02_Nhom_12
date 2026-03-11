import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
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
      body: IndexedStack(
        index: stt,
        children: [
          Text('day la Trang chủ'),
          Text('day la trang thông tin'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex : stt,
        onTap: (i) {
          setState(() {
            stt = i;
          });
        },
        items : [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Thông tin',
          ),
        ],
      ),
    );
  }
}