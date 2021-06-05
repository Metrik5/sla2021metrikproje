import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slaproject/ekranlar/anasayfa.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:slaproject/ekranlar/kay%C4%B1t.dart';


class GirisEkrani extends StatefulWidget {
  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {

  final dbRef = FirebaseDatabase.instance.reference().child("users");
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _hatirla = false;

  Widget _email(){
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Text('Email Adresiniz:', 
        style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)
        ),
        SizedBox(height: 12.0),
        Container(

          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(5.0),
          ),
          height: 60.0,
          child: TextField(
            controller: usernameController,
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.brown),
            decoration: InputDecoration(border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 2.0),
            prefixIcon: Icon(Icons.email, color: Colors.white60,),
          hintText: 'Kullanıcı Adınızı giriniz.',
          hintStyle: TextStyle(color: Colors.black45),
           ),
          ),
        ),
      ],
    );
  }

  Widget _password(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget> [
        Text('Sifreniz.', style: TextStyle(color: Colors.white,   fontWeight: FontWeight.bold,),),
        SizedBox(height: 12.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(color: Colors.brown),
            decoration: InputDecoration(border: InputBorder.none,
            contentPadding:EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 2.0),
            prefixIcon: Icon(Icons.lock, color: Colors.black12,),
            hintText: 'Sifrenizi giriniz.',
            ),
          ),
        ),
      ],
    );
  }

Widget _passwordunutma(){
  return Container(
    alignment: Alignment.centerLeft,
    child: FlatButton(
      onPressed: () => print("Butona basıldı."),
      padding: EdgeInsets.all(1.0),
      child: Text( 
        'Sifrenizimi unuttunuz ? '  ,
      ),
    ),
  );
}

Widget _girisbutonu(){
  return Container(
    padding: EdgeInsets.symmetric(vertical:20.0),
    width: double.infinity,
    child: RaisedButton(
      elevation: 5.0,
      onPressed: () {

        if(!usernameController.text.contains("@")){

          displayToastMessage("Doğru bir email adresi giriniz.", context);
        }
                      
        else if (passwordController.text.length <7) {
          displayToastMessage("Lütfen 6 haneli veya daha fazla bir şifre giriniz.", context);         
        } 

        else {

        loginUser(context);
        }
      },
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
              color: Colors.white,
              child: Text(
                'GİRİS',
                style: TextStyle(
                  color: Colors.black45,
                  letterSpacing: 1.0,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
        
        
        
        
        Widget _kayitbutonu(){
          return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>KayitEkrani()),);
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Kaydınız yok mu? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: ' Kayıt ol.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
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
                value: SystemUiOverlayStyle.light ,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Stack(children:<Widget> [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.purple[100],Colors.purple[200],Colors.purple[300],Colors.purple[400],
                          ],
                          stops: [0.1,0.4,0.7,0.9],
                        )
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:<Widget> [
                            Text("Sla Platformumuza Hoşgeldiniz", style: TextStyle(fontSize: 35.0,color: Colors.red),),
        
                            SizedBox(height: 20.0,),
        
                            Text("Giriş Yap", style: TextStyle(fontSize: 25.0, color: Colors.red[400]),),
        
                            SizedBox(height: 30.0,),
        
                            _email(),
        
                            SizedBox(height: 30.0,),
        
                            _password(),
                            _passwordunutma(),
                            _kayitbutonu(),
                            _girisbutonu()
        
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
            
   final User firebaseUser = (
    await _firebaseAuth.signInWithEmailAndPassword(
      email: usernameController.text, 
      password: passwordController.text
    ).catchError((errMsg){
       displayToastMessage("Error:"+errMsg.toString(), context);
    })).user;

    if(firebaseUser !=null){

    dbRef.child(firebaseUser.uid).once().then((DataSnapshot snap){
      if(snap.value != null){
        Navigator.push(context, MaterialPageRoute( builder: (context) => anasayfa()),);
        displayToastMessage("Giriş yapıldı.", context);
      }
      else{
        _firebaseAuth.signOut();
        displayToastMessage("Bu kullanıcı bulunamadı.", context);
      }
    });
  }
    else{
      displayToastMessage("Kullanıcı girişi yapılamadı.", context);
    }
  } 

}
