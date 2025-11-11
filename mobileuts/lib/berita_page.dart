import 'package:flutter/material.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> beritaList = [
      {
        'judul': 'Cuaca Ekstrem Melanda Bandung',
        'deskripsi': 'Hujan deras disertai angin kencang menyebabkan beberapa pohon tumbang di wilayah Bandung.',
        'gambar': 'https://cdn-icons-png.flaticon.com/512/1146/1146869.png',
      },
      {
        'judul': 'Inovasi Mahasiswa UPI',
        'deskripsi': 'Mahasiswa menciptakan aplikasi pemantauan sampah berbasis AI.',
        'gambar': 'https://cdn-icons-png.flaticon.com/512/616/616408.png',
      },
      {
        'judul': 'Peningkatan Kualitas Udara',
        'deskripsi': 'Upaya pemerintah dalam mengurangi emisi mulai menunjukkan hasil positif.',
        'gambar': 'https://cdn-icons-png.flaticon.com/512/3262/3262970.png',
      },
      {
        'judul': 'Festival Teknologi 2025',
        'deskripsi': 'Event menampilkan inovasi teknologi terbaru di bidang AI dan IoT.',
        'gambar': 'https://cdn-icons-png.flaticon.com/512/2972/2972185.png',
      },
      {
        'judul': 'Edukasi Digital untuk Pelajar',
        'deskripsi': 'Program pelatihan coding dasar bagi pelajar.',
        'gambar': 'https://cdn-icons-png.flaticon.com/512/1077/1077012.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Berita'), backgroundColor: Colors.green),
      backgroundColor: Colors.green.shade50,
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: beritaList.length,
        itemBuilder: (context, index) {
          final b = beritaList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(b['gambar']!, width: 70, height: 70, fit: BoxFit.cover),
              ),
              title: Text(b['judul']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              subtitle: Text(b['deskripsi']!),
            ),
          );
        },
      ),
    );
  }
}
