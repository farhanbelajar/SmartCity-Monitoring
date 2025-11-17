import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lottie/lottie.dart';

class CatagoryPage extends StatefulWidget {
  const CatagoryPage({super.key});

  @override
  State<CatagoryPage> createState() => _CatagoryPageState();
}

class _CatagoryPageState extends State<CatagoryPage> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  bool isButtonEnable1 = false;
  bool isButtonEnable2 = false;
  dynamic varlamp1;
  dynamic varlamp2;
  dynamic sensorbh1750;
  int buttonStatus1 = 0;
  int buttonStatus2 = 0;

  // Data deteksi
  Map<String, dynamic> detectionData = {
    'car': {
      'confidence': 0.0,
      'height': 0,
      'width': 0,
      'x': 0,
      'y': 0,
    },
  };

  @override
  void initState() {
    super.initState();
    _listenToFirebaseData();
  }

  void _listenToFirebaseData() {
    _databaseRef.child('Lamp1').onValue.listen((event) {
      final getvarlamp1 = event.snapshot.value;
      setState(() {
        varlamp1 = getvarlamp1;
        buttonStatus1 = (varlamp1 == 'On') ? 1 : 0;
      });
    });

    _databaseRef.child('Lamp2').onValue.listen((event) {
      final getvarlamp2 = event.snapshot.value;
      setState(() {
        varlamp2 = getvarlamp2;
        buttonStatus2 = (varlamp2 == 'On') ? 1 : 0;
      });
    });

    _databaseRef.child('LightLevel').onValue.listen((event) {
      final getsensorbh1750 = event.snapshot.value;
      setState(() {
        sensorbh1750 = getsensorbh1750;
      });
    });

    _databaseRef.child('detections').onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null && data.containsKey('car')) {
        setState(() {
          detectionData = {
            'car': {
              'confidence': data['car']['confidence'] ?? 0.0,
              'height': data['car']['height'] ?? 0,
              'width': data['car']['width'] ?? 0,
              'x': data['car']['x'] ?? 0,
              'y': data['car']['y'] ?? 0,
            },
          };
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7FA1C3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Card(
                color: Color(0xFFE2DAD6),
                elevation: 10,
                child: ListTile(
                  title: Center(child: Text('Lamp Status')),
                  subtitle: Column(
                    children: [
                      _buildLampControl('Lamp 1', varlamp1, isButtonEnable1, buttonStatus1, 'Lamp1', (value) {
                        setState(() {
                          isButtonEnable1 = value;
                        });
                        _databaseRef.child('Lamp1').set(value ? 'Auto' : 'Off');
                      }, () async {
                        await _toggleLamp('Lamp1', buttonStatus1);
                      }),
                      _buildLampControl('Lamp 2', varlamp2, isButtonEnable2, buttonStatus2, 'Lamp2', (value) {
                        setState(() {
                          isButtonEnable2 = value;
                        });
                        _databaseRef.child('Lamp2').set(value ? 'Auto' : 'Off');
                      }, () async {
                        await _toggleLamp('Lamp2', buttonStatus2);
                      }),
                    ],
                  ),
                ),
              ),
              // Card untuk data deteksi
              Card(
                elevation: 10,
                color: Color(0xFFE2DAD6),
                child: ListTile(
                  title: Center(child: Text('Mendeteksi Mobil')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Center(
                            child: Container(
                              width: 200,
                              height: 150,
                              child: Lottie.asset("assets/mobil.json", fit: BoxFit.cover),
                            ),
                          ),
                          Text("Hasil Deteksi")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDetectionInfo('Confidence', detectionData['car']['confidence']),
                          _buildDetectionInfo('Height', detectionData['car']['height']),
                          _buildDetectionInfo('Width', detectionData['car']['width']),
                          _buildDetectionInfo('X', detectionData['car']['x']),
                          _buildDetectionInfo('Y', detectionData['car']['y']),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  
                ],
              ),
              Card(
                color: Color(0xFFE2DAD6),
                child: ListTile(
                  title: Center(child: Text("Cahaya : $sensorbh1750")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLampControl(
      String lampName,
      dynamic lampStatus,
      bool isAuto,
      int buttonStatus,
      String lampKey,
      ValueChanged<bool> onSwitchChanged,
      VoidCallback onPressed,
      ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: (lampStatus == 'On') ? Colors.green : Colors.red,
                ),
                SizedBox(width: 10),
                Text('$lampName: $lampStatus'),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: isAuto
                  ? Text(
                'Auto',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              )
                  : Text(
                buttonStatus == 0 ? 'On' : 'Off',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonStatus == 0 ? Color(0xff363062) : Color(0xff5C4B99),
                side: BorderSide(color: Colors.black),
                disabledBackgroundColor: Colors.grey,
              ),
              onPressed: isAuto ? null : onPressed,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('Manual'),
                  Switch(
                    value: isAuto,
                    onChanged: onSwitchChanged,
                  ),
                  const Text('Auto'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _toggleLamp(String lampKey, int buttonStatus) async {
    try {
      await _databaseRef.child(lampKey).set(buttonStatus == 0 ? 'On' : 'Off');
    } catch (e) {
      SnackBar snackbarMessage = SnackBar(content: Text('Gagal update data'));
      ScaffoldMessenger.of(context).showSnackBar(snackbarMessage);
    }
  }

  Widget _buildDetectionInfo(String label, dynamic value) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          child: Icon(Icons.info_outline),
        ),
        Text(label),
        Text('$value'),
      ],
    );
  }
}
