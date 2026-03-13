import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Combined: Scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text('THÔNG TIN'),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        //Layout: Column (Xếp dọc)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            //Output: Image
            Center(
              child: Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', 
                height: 100,
              ),
            ),
            const SizedBox(height: 30),

            // Dòng 1: Nhóm 12
            Row(
              children: [
                const Icon(Icons.group, color: Colors.orange, size: 30),
                const SizedBox(width: 15),
                const Text('Nhóm: Nhóm 12', style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 20),

            // Dòng 2: Thành viên
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.person, color: Colors.orange, size: 30),
                const SizedBox(width: 15),
                const Text('Thành viên:\nNguyễn Mạnh Hòa - 23010254', style: TextStyle(fontSize: 18)), 
              ],
            ),
            const SizedBox(height: 20),

            // Dòng 3: Lớp
            Row(
              children: [
                const Icon(Icons.school, color: Colors.orange, size: 30),
                const SizedBox(width: 15),
                const Text('Lớp: lttbđ', style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 20),

            // Dòng 4: Link github 
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.link, color: Colors.orange, size: 30),
                const SizedBox(width: 15),
                Expanded(
                  child: const Text(
                    'Link github: https://github.com/ManhHoa2405/2025_2_LTTBDD_N02_Nhom_12', 
                    style: TextStyle(fontSize: 18)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}