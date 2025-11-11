// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Aplikasi Multi Fitur",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/foto_anda.jpg'),
            ),
            SizedBox(height: 20),
            Text("Nama: Muhammad Zhabiansyah Lazuardi",
                style: TextStyle(fontSize: 18)),
            Text("NIM: 1234567890", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
