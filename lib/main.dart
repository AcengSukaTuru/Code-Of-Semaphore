import 'package:flutter/material.dart';
import 'home_page.dart'; // File terpisah untuk tampilan game

void main() {
  runApp(MyGameApp());
}

class MyGameApp extends StatelessWidget {
  const MyGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game App',
      theme: ThemeData(
        primaryColor: Color(0xFFA67B5B), // Warna utama aplikasi
      ),
      home: HomePage(), // Panggil halaman Home di file terpisah
    );
  }
}
