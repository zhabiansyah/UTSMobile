import 'package:flutter/material.dart';
import 'dart:math';

class KontakPage extends StatelessWidget { // ✅ perbaikan nama kelas
  const KontakPage({super.key});

  // Daftar kontak statis
  final List<Map<String, String>> kontakList = const [
    {"nama": "Andi Wijaya", "telepon": "0812-3456-7890"},
    {"nama": "Budi Santoso", "telepon": "0813-4567-8901"},
    {"nama": "Citra Lestari", "telepon": "0814-5678-9012"},
    {"nama": "Dewi Anggraini", "telepon": "0815-6789-0123"},
    {"nama": "Eka Pratama", "telepon": "0816-7890-1234"},
    {"nama": "Fajar Ramadhan", "telepon": "0817-8901-2345"},
    {"nama": "Gita Ananda", "telepon": "0818-9012-3456"},
    {"nama": "Hendra Saputra", "telepon": "0819-0123-4567"},
    {"nama": "Intan Permata", "telepon": "0821-1234-5678"},
    {"nama": "Joko Susilo", "telepon": "0822-2345-6789"},
    {"nama": "Karin Amelia", "telepon": "0823-3456-7890"},
    {"nama": "Lutfi Rahman", "telepon": "0824-4567-8901"},
    {"nama": "Maya Sari", "telepon": "0825-5678-9012"},
    {"nama": "Nanda Putra", "telepon": "0826-6789-0123"},
    {"nama": "Oni Prasetyo", "telepon": "0827-7890-1234"},
  ];

  // Fungsi untuk menghasilkan warna acak pada avatar
  Color _randomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(200), // sedikit dikurangi biar warnanya tidak terlalu terang
      random.nextInt(200),
      random.nextInt(200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: kontakList.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final kontak = kontakList[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: _randomColor(),
                child: Text(
                  kontak["nama"]![0],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                kontak["nama"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                kontak["telepon"]!,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              trailing: const Icon(Icons.phone, color: Colors.green),
            ),
          );
        },
      ),
    );
  }
}
