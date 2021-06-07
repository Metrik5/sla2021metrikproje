import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'ekranlar/giris.dart';
import 'package:flutter/services.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());

}

final DatabaseReference dbRef = FirebaseDatabase.instance.reference();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sla Login',
      debugShowCheckedModeBanner: false,
      home: GirisEkrani(),


    );


  }
  
}


