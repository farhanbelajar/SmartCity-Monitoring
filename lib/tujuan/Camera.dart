import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Camera_Page extends StatefulWidget {
  const Camera_Page({super.key});

  @override
  State<Camera_Page> createState() => _Camera_PageState();
}

class _Camera_PageState extends State<Camera_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penjelasan ESP32-CAM', style: GoogleFonts.montserrat()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fungsi ESP32-CAM',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '1. Mengambil Gambar dan Mengirim ke Telegram',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'ESP32-CAM digunakan untuk mengambil gambar ketika sensor ultrasonik mendeteksi objek dengan jarak kurang dari 5 cm. Gambar yang diambil kemudian dikirimkan secara otomatis ke Telegram.',
              style: GoogleFonts.montserrat(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '2. Menganalisa Ketinggian dan Lebar Kendaraan',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'ESP32-CAM yang lain digunakan untuk menganalisa ketinggian dan lebar kendaraan menggunakan Edge Impulse. Data hasil analisis ini kemudian dikirimkan ke Firebase untuk pemantauan lebih lanjut.',
              style: GoogleFonts.montserrat(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
