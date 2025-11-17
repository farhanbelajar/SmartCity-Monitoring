import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Telegram_Page extends StatefulWidget {
  const Telegram_Page({super.key});

  @override
  State<Telegram_Page> createState() => _Telegram_PageState();
}

class _Telegram_PageState extends State<Telegram_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penjelasan Telegram'),
      ),
      body: SingleChildScrollView( // Menambahkan scroll
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Penggunaan Telegram dalam Sistem',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Telegram digunakan untuk menerima pesan berupa gambar dan hasil deteksi sensor, seperti sensor ultrasonik dan sensor PIR. '
                    'Pesan gambar yang diterima oleh Telegram berasal dari ESP32-CAM. '
                    'Telegram ini juga memiliki tiga perintah utama yang bisa digunakan:',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '1. /photo: Perintah ini digunakan untuk mengambil gambar menggunakan ESP32-CAM.',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '2. /flash: Perintah ini digunakan untuk menyalakan LED pada kamera ESP32-CAM.',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '3. /sensor: Perintah ini digunakan untuk mengetahui nilai deteksi dari sensor yang terhubung, seperti sensor ultrasonik dan sensor PIR.',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Dengan perintah-perintah tersebut, pengguna dapat memantau dan mengontrol sistem secara real-time melalui Telegram.',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
