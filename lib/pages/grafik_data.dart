import 'package:apk_tes/server/real_time_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class GrafikData extends StatefulWidget {
  const GrafikData({super.key});

  @override
  State<GrafikData> createState() => _GrafikDataState();
}

class _GrafikDataState extends State<GrafikData> {
  dynamic sensorbh1750;
  List<FlSpot> intensitasCahaya = [];
  List<String> timeLabels = [];
  DateTime startTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    // Mendapatkan data dari Firebase Realtime Database
    LightLevel.onValue.listen((event) async {
      final getSensorResult = event.snapshot;
      setState(() {
        sensorbh1750 = getSensorResult.value;
      });

      // Menyimpan data ke SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('sensorbh1750', sensorbh1750.toDouble());

      // Memuat data yang disimpan ke dalam grafik
      double? savedSuhu = prefs.getDouble('sensorbh1750');
      if (savedSuhu != null) {
        setState(() {
          DateTime now = DateTime.now();
          String formattedTime = DateFormat('HH:mm:ss').format(now);

          // Menghitung nilai x sebagai perbedaan waktu dalam detik dari waktu mulai
          double elapsedTime = now.difference(startTime).inSeconds.toDouble();

          intensitasCahaya.add(FlSpot(elapsedTime, savedSuhu));
          timeLabels.add(formattedTime);

          // Menjaga grafik untuk menampilkan data 10 menit terakhir (600 detik)
          if (intensitasCahaya.length > 600) {
            intensitasCahaya.removeAt(0);
            timeLabels.removeAt(0);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Warna dengan opasitas untuk grid line
    final Color gridLineColor = const Color(0xFF7FA1C3).withOpacity(0.2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafik Intensitas Cahaya'),
        backgroundColor: const Color(0xFF7FA1C3),
      ),
      backgroundColor: const Color(0xFFE2DAD6),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // mengatur posisi bayangan
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LineChart(
              LineChartData(
                maxY: 100,
                minY: 0,
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: gridLineColor,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    axisNameWidget: const Text(
                      'Time',
                      style: TextStyle(color: Colors.purple, fontFamily: 'Balance'),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value ~/ 60;
                        if (index >= 0 && index < timeLabels.length) {
                          return Text(
                            timeLabels[index],
                            style: const TextStyle(
                              color: Color(0xFF7FA1C3),
                              fontFamily: 'Balance',
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      interval: 60, // Menampilkan label setiap menit (60 detik)
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 25,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toString(),
                          style: const TextStyle(
                            color: Color(0xFF7FA1C3),
                            fontFamily: 'Balance',
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xFF7FA1C3)),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: intensitasCahaya,
                    isCurved: true,
                    barWidth: 2,
                    color: const Color(0xFF7FA1C3),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF7FA1C3).withOpacity(0.3),
                    ),
                    dotData: const FlDotData(show: true),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipRoundedRadius: 8,
                    tooltipPadding: const EdgeInsets.all(8),
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        final index = touchedSpot.spotIndex;
                        final value = touchedSpot.y;
                        final time = timeLabels[index];
                        return LineTooltipItem(
                          '$value%\n$time',
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
