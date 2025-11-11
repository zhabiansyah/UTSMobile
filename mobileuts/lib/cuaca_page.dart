import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CuacaPage extends StatelessWidget {
  const CuacaPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA8E063), Color(0xFF56AB2F)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Perkiraan Cuaca Hari Ini',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Kota Bandung, Indonesia',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 30),

              // ANIMASI CUACA
              Lottie.asset(
                'asset/sunny.json',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),

              // SUHU UTAMA
              const Text(
                '29°C',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Cerah Berawan',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 30),

              // INFO TAMBAHAN
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 8,
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _WeatherInfo(
                              icon: Icons.water_drop,
                              label: 'Kelembapan',
                              value: '78%',
                            ),
                            _WeatherInfo(
                              icon: Icons.air,
                              label: 'Angin',
                              value: '10 km/jam',
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _WeatherInfo(
                              icon: Icons.thermostat,
                              label: 'Suhu Min',
                              value: '23°C',
                            ),
                            _WeatherInfo(
                              icon: Icons.wb_sunny,
                              label: 'Suhu Max',
                              value: '31°C',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                'Data masih bersifat statis.\nAPI cuaca akan ditambahkan nanti 🌤️',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget Kecil untuk Menampilkan Info Cuaca
class _WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.green, size: 30),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
