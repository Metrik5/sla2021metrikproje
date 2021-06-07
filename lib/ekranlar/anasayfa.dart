import 'package:flutter/material.dart';
import 'package:slaproject/ekranlar/gelenler.dart';
import 'package:slaproject/ekranlar/mevcut.dart';
import 'package:slaproject/ekranlar/rapor.dart';
import 'package:slaproject/ekranlar/talepolustur.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class sli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/images/drawer.png"),
                  fit: BoxFit.cover,
                ),
                color: Colors.purple[200],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.add,
              color: Colors.orange,
              size: 40.0,
            ),
            title: Text('Talep Oluştur'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TalepOlus()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.subdirectory_arrow_right_sharp,
              color: Colors.green,
              size: 40.0,
            ),
            tileColor: Colors.purple[100],
            title: Text('Mevcut Taleplerim'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => mevcutekrani()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.arrow_circle_down_sharp,
              color: Colors.green,
              size: 40.0,
            ),
            title: Text('Gelen Talepler'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => gelenlerekrani()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.report_sharp,
              color: Colors.red,
              size: 40.0,
            ),
            tileColor: Colors.purple[100],
            title: Text('Raporlarım'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => raporekrani()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class anasayfa extends StatefulWidget {
  @override
  _anasayfaState createState() => _anasayfaState();
}

class _anasayfaState extends State<anasayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("SLA Uygulaması"),
        shadowColor: Colors.purple,
        backgroundColor: Colors.purple[400],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple[100],
                  Colors.purple[200],
                  Colors.purple[300],
                  Colors.purple[400],
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              )),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sla Platformumuza Hoşgeldiniz",
                      style: TextStyle(fontSize: 35.0, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: sli(),
    );
  }
}

class TalepOlus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talep Oluştur',
      home: talepolustur(),
    );
  }
}

class raporekrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rapor ",
      home: rapor(),
    );
  }
}

class gelenlerekrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gelenler",
      home: gelenler(),
    );
  }
}

class mevcutekrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mevcut Talepler",
      home: mevcut(),
    );
  }
}
