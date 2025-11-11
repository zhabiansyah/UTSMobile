import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'biodata_page.dart';
import 'kontak_page.dart';
import 'kalkulator_page.dart';
import 'cuaca_page.dart';
import 'berita_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTS Mobile',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const BiodataPage(),
    const KontakPage(),
    const KalkulatorPage(),
    const CuacaPage(),        // ✅ DITAMBAHKAN const
    const BeritaPage(),
  ];

  final List<String> _titles = [
    'Biodata',
    'Kontak',
    'Kalkulator',
    'Cuaca',
    'Berita',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Biodata'),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: 'Kontak'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Kalkulator'),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Cuaca'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Berita'),
        ],
      ),
    );
  }
}