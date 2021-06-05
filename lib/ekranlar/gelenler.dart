import 'package:flutter/material.dart';

import 'anasayfa.dart';


class gelenler extends StatefulWidget {
  @override
  _gelenlerState createState() => _gelenlerState();
}

class _gelenlerState extends State<gelenler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(centerTitle: true, title: Text("Sla Uygulaması"),shadowColor: Colors.purple, backgroundColor: Colors.purple[400],),
      body:  GestureDetector(
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
                    Text("Gelen Talepler Ekranımıza Hoşgeldiniz.",textAlign:TextAlign.center , style: TextStyle(fontSize: 35.0,color: Colors.red,),),

                  

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