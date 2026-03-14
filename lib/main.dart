import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  await Hive.openBox('ghiChuBox');
  
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), 
    ),
  );
}