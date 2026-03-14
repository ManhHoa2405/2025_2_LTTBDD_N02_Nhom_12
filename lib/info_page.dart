import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final bool isVietnamese; 

  const InfoPage({super.key, required this.isVietnamese});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      // LAYOUT: Sử dụng Column để xếp dọc các phần tử
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            // OUTPUT: Sử dụng Image để hiển thị ảnh minh họa
            child: Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', 
              height: 100,
            ),
          ),
          const SizedBox(height: 30),
          
          _buildRow(Icons.group, 'Nhóm: Nhóm 12', 'Group: Group 12'),
          const SizedBox(height: 20),
          _buildRow(Icons.person, 'Thành viên:\nNguyễn Mạnh Hòa - 23010254', 'Member:\nNguyen Manh Hoa - 23010254'),
          const SizedBox(height: 20),
          _buildRow(Icons.school, 'Lớp: lttbđ', 'Class: lttbđ'),
          const SizedBox(height: 20),
          _buildRow(Icons.link, 'Link github: https://github.com/ManhHoa2405/2025_2_LTTBDD_N02_Nhom_12', 'GitHub Link: https://github.com/ManhHoa2405/2025_2_LTTBDD_N02_Nhom_12', isLink: true),
        ],
      ),
    );
  }

  Widget _buildRow(IconData icon, String viText, String enText, {bool isLink = false}) {
    // LAYOUT: Sử dụng Row để xếp ngang Icon và Text
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.amber, size: 30),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            isVietnamese ? viText : enText, 
            style: TextStyle(
              fontSize: 18, 
              color: isLink ? Colors.blue : Colors.black, 
            ),
          ),
        ),
      ],
    );
  }
}