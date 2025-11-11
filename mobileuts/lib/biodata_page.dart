import 'package:flutter/material.dart';
import 'dart:math';

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  String? _gender;
  late String _randomPhotoUrl;

  final List<String> _randomImages = [
    'https://randomuser.me/api/portraits/men/11.jpg',
    'https://randomuser.me/api/portraits/men/22.jpg',
    'https://randomuser.me/api/portraits/men/33.jpg',
    'https://randomuser.me/api/portraits/women/44.jpg',
    'https://randomuser.me/api/portraits/women/55.jpg',
    'https://randomuser.me/api/portraits/women/66.jpg',
  ];

  @override
  void initState() {
    super.initState();
    // ambil gambar random saat halaman dibuka
    _randomPhotoUrl = _randomImages[Random().nextInt(_randomImages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Biodata Mahasiswa',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),

            // FOTO PROFIL RANDOM
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(_randomPhotoUrl),
            ),
            const SizedBox(height: 10),
            const Text(
              'Foto profil dipilih secara acak',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // INPUT NAMA
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),

            // INPUT NIM
            TextField(
              controller: _nimController,
              decoration: InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.credit_card),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // JENIS KELAMIN
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Jenis Kelamin',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Laki-laki'),
                    value: 'Laki-laki',
                    groupValue: _gender,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Perempuan'),
                    value: 'Perempuan',
                    groupValue: _gender,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // TOMBOL TAMPILKAN DATA
            ElevatedButton.icon(
              onPressed: () {
                if (_namaController.text.isEmpty ||
                    _nimController.text.isEmpty ||
                    _gender == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Harap isi semua data biodata!'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Data Biodata'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(_randomPhotoUrl, width: 100),
                          const SizedBox(height: 10),
                          Text('Nama: ${_namaController.text}'),
                          Text('NIM: ${_nimController.text}'),
                          Text('Gender: $_gender'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: const Icon(Icons.save),
              label: const Text('Tampilkan Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
