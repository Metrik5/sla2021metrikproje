import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slaproject/ekranlar/anasayfa.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:slaproject/ekranlar/giris.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KayitEkrani extends StatefulWidget {
  KayitEkrani({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _KayitEkraniState createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Kayıt Ol ",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              RegisterUser(),
            ]),
      )),
    );
  }
}

class RegisterUser extends StatefulWidget {
  RegisterUser({Key key}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();
  final listOfDepartment = [
    'Bilgi İşlem',
    'Lojistik',
    'İnsan Kaynakları',
    'Hukuk',
    'Yönetim'
  ];
  String dropdownValue = 'Bilgi İşlem';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final dbRef = FirebaseDatabase.instance.reference().child("users");

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: usernameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(0,14,0,0),
                  hintText: 'Kullanıcı Adı',
                  hintStyle: TextStyle(color: Colors.black),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Kullanıcıyı Giriniz.';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: DropdownButtonFormField(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0,14,0,0),
                labelText: "Departman",
              ),
              items: listOfDepartment.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Lutfen kullanıcıyı seçiniz';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: passwordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(0,14,0,0),
                  hintText: 'Şifre',
                  hintStyle: TextStyle(color: Colors.black),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Lütfen giriniz.';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      if (!usernameController.text.contains("@")) {
                        displayToastMessage(
                            "Doğru bir email adresi giriniz.", context);
                      } else if (passwordController.text.length < 7) {
                        displayToastMessage(
                            "Lütfen 6 haneli veya daha fazla bir şifre giriniz.",
                            context);
                      } else {
                        registerNewUser(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      fixedSize: Size(130, 70),
                    ),
                    child: Text('Gönder',),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => anasayfa()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      fixedSize: Size(130, 70),
                    ),
                    child: Text('Yönlendir'),
                  ),
                ],
              )),
        ])));
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: usernameController.text,
                password: passwordController.text)
            .catchError((errMsg) {
      displayToastMessage("Error:" + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      Map userDataMap = {
        "name": usernameController.text.trim(),
        "password": passwordController.text.trim(),
        "Departman": dropdownValue,
      };
      dbRef.child(firebaseUser.uid).set(userDataMap);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => anasayfa()),
      );
    } else {
      displayToastMessage("Kullanıcı kayıdı yapılamadı.", context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
