import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slaproject/ekranlar/anasayfa.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:slaproject/ekranlar/kay%C4%B1t.dart';
import 'package:google_fonts/google_fonts.dart';

class GirisEkrani extends StatefulWidget {
  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  final dbRef = FirebaseDatabase.instance.reference().child("users");
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _hatirla = false;

  Widget _title() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'S',
            style: GoogleFonts.portLligatSans(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 50,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10),
            ),
            children: [
              TextSpan(
                text: 'L',
                style: TextStyle(color: Colors.black, fontSize: 40),
              ),
              TextSpan(
                text: 'A',
                style: TextStyle(color: Color(0xffe46b10), fontSize: 50),
              ),
            ]),
      ),
    );
  }

  Widget _email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('E-Mail',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16.0)),
        SizedBox(height: 12.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(5.0),
          ),
          height: 60.0,
          child: TextField(
            controller: usernameController,
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(0, 14, 0, 0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white60,
              ),
              hintText: 'Lütfen geçerli bir mail adresi giriniz',
              hintStyle: TextStyle(color: Colors.black54),
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  Widget _password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Parola',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(0, 19, 0, 0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black12,
              ),
              hintText: 'Sifrenizi giriniz',
              hintStyle: TextStyle(color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordunutma() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print("Butona basıldı."),
        padding: EdgeInsets.all(1.0),
        child: Text(
          'Şifremi unuttum ',
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        if (!usernameController.text.contains("@")) {
          displayToastMessage("Doğru bir email adresi giriniz.", context);
        } else if (passwordController.text.length < 7) {
          displayToastMessage(
              "Lütfen 6 haneli veya daha fazla bir şifre giriniz.", context);
        } else {
          loginUser(context);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('veya'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _registerButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KayitEkrani()),
        );
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hesabınız yok mu ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Hemen kaydolun',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _title(),
                      _email(),
                      _password(),
                      _passwordunutma(),
                      _submitButton(),
                      _divider(),
                      _registerButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginUser(BuildContext context) async {
    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: usernameController.text,
                password: passwordController.text)
            .catchError((errMsg) {
      displayToastMessage("Error:" + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      dbRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => anasayfa()),
          );
          displayToastMessage("Giriş yapıldı.", context);
        } else {
          _firebaseAuth.signOut();
          displayToastMessage("Bu kullanıcı bulunamadı.", context);
        }
      });
    } else {
      displayToastMessage("Kullanıcı girişi yapılamadı.", context);
    }
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green[800];
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
