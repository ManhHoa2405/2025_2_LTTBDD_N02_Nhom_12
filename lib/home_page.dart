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
        title: Text(index == null ? 'Thêm khoản chi mới' : 'Sửa khoản chi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: tenController, decoration: const InputDecoration(hintText: 'Tên khoản chi')),
            const SizedBox(height: 10),
            TextField(controller: tienController, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: 'Số tiền')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () async {
              if (tenController.text.isNotEmpty && tienController.text.isNotEmpty) {
                setState(() {
                  if (index == null) {
                    // Thêm mới
                    danhSachThuChi.add({'ten': tenController.text, 'tien': tienController.text});
                  } else {
                    // Cập nhật
                    danhSachThuChi[index] = {'ten': tenController.text, 'tien': tienController.text};
                  }
                });
                await _myBox.put('danhSachThuChi', danhSachThuChi);
                if (mounted) Navigator.pop(context);
              }
            },
            child: Text(index == null ? 'Lưu' : 'Cập nhật'), 
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SỔ THU CHI'),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildHeader(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft, 
              child: Text('Lịch sử', style: TextStyle(fontWeight: FontWeight.bold))
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: danhSachThuChi.length,
              itemBuilder: (context, index) => _buildListItem(index),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _hienThiCuaSo(),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Tổng chi tiêu:'),
          Text(
            '- $tongTien đ', 
            style: const TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold)
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(int index) {
    final item = danhSachThuChi[index];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: ListTile(
        leading: const Icon(Icons.shopping_cart, color: Colors.orange),
        title: Text(item['ten']!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${item['tien']} đ', style: const TextStyle(color: Colors.red)),
            const SizedBox(width: 15),
            
            GestureDetector(
              onTap: () => _hienThiCuaSo(index: index), 
              child: const Icon(Icons.edit, color: Colors.blue),
            ),
            
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () async {
                setState(() => danhSachThuChi.removeAt(index));
                await _myBox.put('danhSachThuChi', danhSachThuChi);
              },
              child: const Icon(Icons.delete, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}