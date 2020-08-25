import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:whiteboard/shared.dart';
import 'dart:math';
import 'package:whiteboard/theme.dart' as Theme;
import 'package:whiteboard/whiteboardstream.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool live = false;
  String email;
  //create random no for every colloboration from whiteboard mobileapp QR to this
  var randomno = new Random();
  String ran;
  _storeFirebase() async {
    //set live as false ,email as '0',and set randomno
    Firestore.instance
        .collection('qrcode')
        .document(ran)
        .setData({'no': ran, 'email': '0', 'live': false});
  }

  @override
  void initState() {
    super.initState();
//here ran variable contains Random no for every scanning
    ran = randomno.nextInt(200000).toString();
    print("random no:" + ran);
    _storeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    //get the email with corresponding qrcode(randomno) : email = "something" {once the QR scanned succesfully through mobile}
    // email ='0' {no one scanning}
    Firestore.instance
        .collection('qrcode')
        .document(ran)
        .snapshots()
        .listen((event) {
      print(event.data['email']);
      email = event.data['email'];
      live = event.data['live'];
    });

    Size size = MediaQuery.of(context).size;
    double wt = size.width;
    double ht = size.height;
    return MaterialApp(
      title: "Online white board",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Online WhiteBoard",
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: wt / 40),
            ),
            backgroundColor: Colors.white60,
            elevation: 20,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            titleSpacing: 2,
          ),
          body: Column(children: <Widget>[
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: ht / 1.5,
                  width: wt,
                  child: Card(
                    //Calling Whiteboard stream and pass corresponding random->QR data
                    child: WhiteBoardStream(
                      random: ran,
                    ),
                  ),
                )
              ],
            ),

            //set sidebar
            Expanded(
              child: Container(
                height: ht - ht / 1.30,
                width: wt,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientStart,
                        Theme.Colors.loginGradientEnd
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Container(
                        height: ht / 5,
                        width: wt / 5,
                        //Add QR image on webapp
                        //ran -> QR data it is replicate on mobile app
                        child: QrImage(
                          data: ran,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(9.0),
                        child: Text(
                          "Scan this QR to make\n Collaboration in your app",
                          style: ts1.copyWith(fontSize: wt / 70),
                        ),
                      ),
                    ])),
              ),
            )
          ])),
    );
  }
}
