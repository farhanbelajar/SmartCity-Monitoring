import 'package:apk_tes/pages/catagory_page.dart';
import 'package:apk_tes/pages/grafik_data.dart';
import 'package:apk_tes/pages/home_page.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final List<Widget> _childern = [HomePage(), CatagoryPage(), GrafikData()];
  int awalindex = 0;

  void tap(int index) {
    setState(() {
      awalindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (awalindex == 0)
          ? CalendarAppBar(
        accent: Color(0xFF6482AD),
        backButton: false,
        locale: 'id',
        onDateChanged: (value) => print(value),
        firstDate: DateTime.now().subtract(Duration(days: 140)),
        lastDate: DateTime.now(),
      )
          : null, // Ensure to set null or some other widget when `awalindex` is not 0
      body: _childern[awalindex],
      backgroundColor: Color(0xFFF5EDED),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                tap(0);
              },
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                tap(1);
              },
              icon: Icon(Icons.sensors),
            ),
            IconButton(
              onPressed: () {
                tap(2);
              },
              icon: Icon(Icons.light),
            ),
          ],
        ),
      ),
    );
  }
}
