import 'package:firebase_database/firebase_database.dart';
final database = FirebaseDatabase.instance.ref();
final Lamp1 = database.child('Lamp1');
final Lamp2 = database.child('Lamp2');
final LightLevel = database.child('LightLevel');