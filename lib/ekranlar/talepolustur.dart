import 'package:flutter/material.dart';
import 'anasayfa.dart';
import 'giris.dart';

class talepolustur extends StatefulWidget {
  @override
  _talepolusturState createState() => _talepolusturState();
}

class _talepolusturState extends State<talepolustur> {

  
  String dropdownValue1 = 'Bilgi İşlem';
  String dropdownValue2 = 'Çok Acil';
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(centerTitle: true, title: Text("Sla Uygulaması"),shadowColor: Colors.purple, backgroundColor: Colors.purple[400],),
      body: GestureDetector(
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

              padding: EdgeInsets.all(10.0),
              child: Column(children: [
            Text('Talebiniz İçin Bir Başlık Giriniz.'),
            SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'Taleb Başlığınız.',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 32.0),
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0)
                  )
              ),
              onChanged: (value) {
                //girilen veri burada gönderilecek
              },
            ),
            SizedBox(height: 10.0),
            Text('Talebiniz.'),
            SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'Talebiniz.',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 32.0),
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0)
                  )
              ),
              onChanged: (value) {
                //girilen veri burada gönderilecek
              },
            ),
            SizedBox(height: 10.0),
            
            SizedBox(height: 10.0),
            Text('Gönderileceği Birimi Seçiniz.'),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(3.0)
              ),
              child: DropdownButton<String>(
                value: dropdownValue1,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, size: 32),
                underline: SizedBox(),
                items: <String>['Bilgi İşlem', 'Lojistik', 'İnsan Kaynakları', 'Hukuk','Yönetim'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  //girilen veri burada gönderilecek
                  setState(() {
                    dropdownValue1 = value;
                  });
                },
              ),
            ),

            Text('Aciliyet Düzeyinizi Giriniz.'),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(3.0)
              ),
              child: DropdownButton<String>(
                value: dropdownValue2,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, size: 32),
                underline: SizedBox(),
                items: <String>['Çok Acil', 'Acil', 'Normal', 'Aciliyeti Bulunmuyor'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  //girilen veri burada gönderilecek
                  setState(() {
                    dropdownValue2 = value;
                  });
                },
              ),
            ),

            SizedBox(height: 10.0),
            Text('Talebiniz İçin İstenilen Son Tarihi Giriniz.'),
            SizedBox(height: 10.0),
            InkWell(
              onTap: () async {
                final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(1994),
                  lastDate: DateTime(2101),
                  builder: (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData.dark(),
                      child: child,
                    );
                  },
                );
                if (picked != null && picked != date)
                  setState(() {
                    date = picked;
                  });
              },
              child: Text('$date  Gönderim Tarihini Giriniz.'),
            ),
            SizedBox(height: 30.0),
            
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              
              MaterialButton(
                color: Colors.orange,
                child: Text('Gönder', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  //girilen veri burada gönderilecek
                },
              ),
            ])
          ])
        
      
             
            ),
          ],
          ),
        ),

      
      drawer: sli(),

      
    );
  }
}