import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:toast/toast.dart';
import 'package:whiteboard/shared.dart';
import 'dart:math';
import 'package:whiteboard/theme.dart' as Theme;
import 'package:whiteboard/whiteboardstream.dart';
//import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool live = false;
  String email;
  var randomno = new Random();
  String ran;
  _storeFirebase() async {
    Firestore.instance
        .collection('qrcode')
        .document(ran)
        .setData({'no': ran, 'email': '0', 'live': false});
  }

  @override
  void initState() {
    super.initState();

    ran = randomno.nextInt(200000).toString();
    print("random no:" + ran);
    _storeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    Firestore.instance
        .collection('qrcode')
        .document(ran)
        .snapshots()
        .listen((event) {
      print(event.data['email']);
      email = event.data['email'];

      print(live);
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

            /*   child:Card(
             shape:RoundedRectangleBorder(
               borderRadius:BorderRadius.circular(20)
             ),
             child:Container(
             
                  padding: EdgeInsets.all(6.0),
             margin: EdgeInsets.all(8.0),

             child: Text("Generate QR",style:ts1.copyWith(fontSize:22)),
             
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

             )    )),)*/

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
          body: Row(
            children: <Widget>[
              Container(
                height: ht,
                width: wt / 5,
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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Container(
                        height: ht / 4,
                        width: wt / 8,
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

                      /*  Padding(
                  padding:EdgeInsets.all(5.0),
                  child:OutlineButton(
                    child: Text("Launch WhiteBoard",style: btnstyle.copyWith(fontSize:wt/60),),
                    onPressed: (){
 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WhiteBoardStream()),
                  );
                    },
                  )
                )*/
                    ])),
              ),
              SizedBox(width: 5),
              Container(
                  height: ht - ht / 5,
                  width: wt - wt / 4,
                  child: WhiteBoardStream(
                    random: ran,
                  )

                  /* live ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget>[
                      Text("White Board",style:TextStyle(fontSize: wt/30,fontWeight: FontWeight.bold)),
                      WhiteBoardStream() ]): */

                  /*  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Image.asset(
                              'assets/scan.jpg',
                              color: Colors.black26,
                              height: ht / 13,
                              width: wt / 15,
                            ),
                            Text("No subscribers")
                          ]),*/
                  )
            ],
          ),
        ));
  }

  Widget classroomIcon(double ht, double wt) {
    return Container(
      height: ht / 10,
      width: wt / 30,
      child: Text("No one scan"), //Image.asset('assets/scan.jpg'),
    );
  }
}
