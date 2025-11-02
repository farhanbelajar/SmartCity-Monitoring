# SmartCity-Monitoring

Aplikasi ini dirancang untuk memantau kondisi lalu lintas dan pencahayaan kota secara real-time. Sistem menggunakan sensor **BH1750** untuk mendeteksi intensitas cahaya di lingkungan sekitar, serta kamera **ESP32-CAM** yang terintegrasi dengan **Edge Impulse AI** untuk mengenali objek kendaraan dan menghitung tinggi serta lebar mobil.

---

## Gambaran Umum Alat

Berikut merupakan tampilan umum alat sistem Smart City Monitoring yang digunakan untuk pengumpulan data dari sensor cahaya dan kamera:

<p align="center">
  <img src="https://github.com/farhanbelajar/SmartCity-Monitoring/blob/main/asset/Sensor%20Ultrasonic%20(2).png" width="600" alt="Gambaran Umum Alat"/>
</p>

---

## Tampilan Aplikasi (UI)

Berikut adalah tampilan antarmuka aplikasi mobile yang digunakan untuk menampilkan data sensor, hasil analisis kamera, serta kontrol sistem secara real-time:

<p align="center">
  <img src="https://github.com/farhanbelajar/SmartCity-Monitoring/blob/main/asset/UI_APK.png" width="420" alt="Tampilan UI Aplikasi"/>
</p>

### Penjelasan Tampilan:
- **Dashboard utama:** menampilkan data intensitas cahaya dari sensor BH1750 dan hasil pengenalan kendaraan dari kamera ESP32-CAM.  
- **Panel kamera:** memperlihatkan hasil deteksi kendaraan menggunakan model AI Edge Impulse (termasuk tinggi dan lebar kendaraan).  
- **Kontrol sistem:** pengguna dapat memantau status pencahayaan dan melakukan pengaturan otomatis/manual berdasarkan kondisi lingkungan.  

---

> **SmartCity-Monitoring** bertujuan untuk mendukung pengelolaan kota yang lebih cerdas dan efisien dengan integrasi teknologi IoT, AI, dan sistem monitoring real-time.
