import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'anasayfa.dart';
import 'package:firebase_database/firebase_database.dart';

class mevcut extends StatefulWidget {
  @override
  _mevcutState createState() => _mevcutState();
}

class _mevcutState extends State<mevcut> {

  final dbRef = FirebaseDatabase.instance.reference().child("Requests").child(FirebaseAuth.instance.currentUser.uid);
  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sla Uygulaması"),
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
              child: FutureBuilder(
                  future: dbRef.once(),
                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      lists.clear();
                      Map<dynamic, dynamic> values = snapshot.data.value;
                      values.forEach((key, values) {
                        lists.add(values);
                      });
                      return new ListView.builder(
                          shrinkWrap: true,
                          itemCount: lists.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsetsDirectional.fromSTEB(0,0, 0, 10),
                              color: Colors.lightBlueAccent,
                              height: 100,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(lists[index]["requestTitle"], style: TextStyle(fontSize: 30),),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Text(lists[index]["department"], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.teal),),
                                    ],
                                  ),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Flexible
                                          (child: Text(lists[index]["request"], style: TextStyle(fontSize: 15),)),
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Text(lists[index]["priority"], style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.red),),
                                      ],
                                    ),
                                  ),
                                ],
                              )

                            );
                          });
                    }
                    return CircularProgressIndicator();
                  }),
            )
          ],
        ),
      ),
      drawer: sli(),
    );
  }
}
