import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> danhSachThuChi = [];
  final _myBox = Hive.box('ghiChuBox');

  @override
  void initState() {
    super.initState();
    var duLieuCu = _myBox.get('danhSachThuChi');
    
    if (duLieuCu != null) {
      danhSachThuChi = (duLieuCu as List).map((item) {
        return {
          'ten': item['ten'].toString(),
          'tien': item['tien'].toString(),
        };
      }).toList();
    }
  }

  // Hàm tính tổng số tiền đã chi
  int tinhTongTien() {
    int tong = 0;
    for (var mucChi in danhSachThuChi) {
      // Ép kiểu chữ (String) sang số nguyên (int) để cộng toán học
      // Dùng tryParse để phòng trường hợp người dùng nhập chữ thay vì số
      int tien = int.tryParse(mucChi['tien'] ?? '0') ?? 0;
      tong += tien;
    }
    return tong;
  }

  void _hienThiCuaSoThemMoi() {
    TextEditingController _tenController = TextEditingController();
    TextEditingController _tienController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Thêm khoản chi mới',
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tenController,
                decoration: InputDecoration(
                  hintText: 'Chi cho việc gì? (VD: Ăn sáng)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _tienController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Số tiền (VD: 30000)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () async {
                if (_tenController.text.isNotEmpty && _tienController.text.isNotEmpty) {
                  setState(() {
                    danhSachThuChi.add({
                      'ten': _tenController.text,
                      'tien': _tienController.text,
                    });
                  });
                  await _myBox.put('danhSachThuChi', danhSachThuChi);
                  Navigator.pop(context);
                }
              },
              child: const Text('Lưu', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Phần hiển thị Tổng tiền đã chi
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Tổng số tiền đã chi',
                  style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  // Gọi hàm tính tổng tiền ở đây
                  '- ${tinhTongTien()} đ',
                  style: const TextStyle(
                    fontSize: 36, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.red
                  ),
                ),
              ],
            ),
          ),
          
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Lịch sử chi tiêu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Phần danh sách các mục chi tiêu
          Expanded(
            child: ListView.builder(
              itemCount: danhSachThuChi.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.monetization_on, color: Colors.orange, size: 30),
                    title: Text(
                      danhSachThuChi[index]['ten']!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    trailing: Text(
                      '- ${danhSachThuChi[index]['tien']} đ',
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _hienThiCuaSoThemMoi,
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}