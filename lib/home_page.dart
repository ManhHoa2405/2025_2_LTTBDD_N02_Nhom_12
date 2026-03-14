import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> danhSachThuChi = [];
  final _myBox = Hive.box('ghiChuBox');
  
  bool isVietnamese = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final data = _myBox.get('danhSachThuChi');
    if (data != null) {
      danhSachThuChi = List<Map<String, String>>.from(
        (data as List).map((e) => Map<String, String>.from(e)),
      );
    }
  }

  int get tongTien => danhSachThuChi.fold(0, (sum, item) => sum + (int.tryParse(item['tien'] ?? '0') ?? 0));

  void _hienThiCuaSo({int? index}) {
    final tenController = TextEditingController(text: index != null ? danhSachThuChi[index]['ten'] : '');
    final tienController = TextEditingController(text: index != null ? danhSachThuChi[index]['tien'] : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null 
            ? (isVietnamese ? 'Thêm khoản chi mới' : 'Add new expense') 
            : (isVietnamese ? 'Sửa khoản chi' : 'Edit expense')),
        // LAYOUT: Dùng Column xếp dọc các ô nhập liệu
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // INPUT: Sử dụng TextField để nhập chữ
            TextField(controller: tenController, decoration: InputDecoration(hintText: isVietnamese ? 'Tên khoản chi' : 'Expense name')),
            const SizedBox(height: 10),
            // INPUT: Sử dụng TextField để nhập số
            TextField(controller: tienController, keyboardType: TextInputType.number, decoration: InputDecoration(hintText: isVietnamese ? 'Số tiền' : 'Amount')),
          ],
        ),
        actions: [
          // INPUT: Sử dụng button (TextButton)
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text(isVietnamese ? 'Hủy' : 'Cancel')
          ),
          // INPUT: Sử dụng button (ElevatedButton)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber, 
              foregroundColor: Colors.black, 
            ),
            onPressed: () async {
              if (tenController.text.isNotEmpty && tienController.text.isNotEmpty) {
                setState(() {
                  if (index == null) {
                    danhSachThuChi.add({'ten': tenController.text, 'tien': tienController.text});
                  } else {
                    danhSachThuChi[index] = {'ten': tenController.text, 'tien': tienController.text};
                  }
                });
                await _myBox.put('danhSachThuChi', danhSachThuChi);
                if (mounted) Navigator.pop(context);
              }
            },
            child: Text(index == null ? (isVietnamese ? 'Lưu' : 'Save') : (isVietnamese ? 'Cập nhật' : 'Update')), 
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Sử dụng Scaffold làm khung sườn cho toàn bộ app
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? (isVietnamese ? 'SỔ THU CHI' : 'EXPENSE TRACKER') : (isVietnamese ? 'THÔNG TIN' : 'INFORMATION'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber, 
        centerTitle: true,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // INPUT: Sử dụng GestureDetector để bắt sự kiện chạm đổi ngôn ngữ
              GestureDetector(
                onTap: () => setState(() => isVietnamese = false), 
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: !isVietnamese ? Colors.blue : Colors.transparent, width: 2),
                  ),
                  child: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () => setState(() => isVietnamese = true), 
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: isVietnamese ? Colors.blue : Colors.transparent, width: 2),
                  ),
                  child: const Text('🇻🇳', style: TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
        ],
      ),
      
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeContent(),
          InfoPage(isVietnamese: isVietnamese),
        ],
      ), 
      
      floatingActionButton: _selectedIndex == 0 
        ? FloatingActionButton(
            onPressed: () => _hienThiCuaSo(),
            backgroundColor: Colors.amber,
            child: const Icon(Icons.add, color: Colors.black),
          )
        : null,

      // NAVIGATION: Thanh điều hướng chuyển tab
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: isVietnamese ? 'Trang chủ' : 'Home'),
          BottomNavigationBarItem(icon: const Icon(Icons.info), label: isVietnamese ? 'Thông tin' : 'Info'),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Column(
      children: [
        _buildHeader(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft, 
            child: Text(isVietnamese ? 'Lịch sử' : 'History', style: const TextStyle(fontWeight: FontWeight.bold))
          ),
        ),
        // OUTPUT: Sử dụng ListView để tạo danh sách cuộn
        Expanded(
          child: ListView.builder(
            itemCount: danhSachThuChi.length,
            itemBuilder: (context, index) => _buildListItem(index),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(isVietnamese ? 'Tổng chi tiêu:' : 'Total Expenses:'),
          Text('- $tongTien đ', style: const TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildListItem(int index) {
    final item = danhSachThuChi[index];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: ListTile(
        leading: const Icon(Icons.shopping_cart, color: Colors.amber),
        title: Text(item['ten']!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${item['tien']} đ', style: const TextStyle(color: Colors.redAccent)),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () => _hienThiCuaSo(index: index), 
              child: Icon(Icons.edit, color: Colors.amber[700]), 
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () async {
                setState(() => danhSachThuChi.removeAt(index));
                await _myBox.put('danhSachThuChi', danhSachThuChi);
              },
              child: const Icon(Icons.delete, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}