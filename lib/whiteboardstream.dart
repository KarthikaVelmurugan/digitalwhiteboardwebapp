

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whiteboardkit/sketch_stream_controller.dart';
import 'package:whiteboardkit/whiteboardkit.dart';

class WhiteBoardStream extends StatefulWidget {
  String random;
  WhiteBoardStream({this.random});
  @override
  _WhiteBoardStreamState createState() => _WhiteBoardStreamState();
}

class _WhiteBoardStreamState extends State<WhiteBoardStream> {
  SketchStreamController controller_stream;
int g=0,balance=0;
    String email;
    bool live;
  @override
  void initState() {
    controller_stream = new SketchStreamController();
     
    getChunk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     Firestore.instance.collection('qrcode').document(widget.random).snapshots().listen((event) {
      print(event.data['email']);
      email = event.data['email'];
      live = event.data['live'];
      print(live);
    
     });
    return  /*Container(
      child:Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child:*/ Whiteboard(
                controller: controller_stream,
              //),
          //  ),
         // ],
        
    //  ) 
       );
  }

  @override
  void dispose() {
      Firestore.instance
                          .collection('qrcode')
                          .getDocuments()
                          .then((snapshot) {
                        for (DocumentSnapshot ds in snapshot.documents) {
                          ds.reference.delete();

                        }
                      
                      });
    controller_stream.close();
    super.dispose();
  }

  void getChunk() {
    /*Firestore.instance
        .collection('books')
        .document('chunk')
        .get()
        .then((DocumentSnapshot ds) {
      // use ds as a snapshot
      var ch = DrawChunk.fromJson(ds.data);
      print(ds.data);
      setState(() {
        controller_stream.addChunk(ch);
        print('a');
      });
    });*/
    int flag;
 // Firestore.instance.collection('qrcode').document(widget.random).snapshots().listen((event) {
    //  print(event.data['flag']);
    //  flag = event.data['flag'];
     // print(flag);
    
   //  });
   print("okkkk");
 print("widget.random"+widget.random);
    Firestore.instance.collection('qrcode').document(widget.random).snapshots().listen((event) {
      print(event.data['email']);
      email = event.data['email'];

/*  Firestore.instance.collection('users').document(email).collection('whiteboard').document(flag.toString()).get().then((DocumentSnapShot){
// DrawChunk.fromJson(DocumentSnapShot.data);
controller_stream.addChunk(DrawChunk.fromJson(DocumentSnapShot.data));
  });
 */

     Firestore.instance
          .collection('users').document(email).collection('whiteboard')
          .snapshots()
          .listen((events) {
            print("length:");
        print(events.documents.length);
        var len = events.documents.length;
       
    
       
        var i=0;
        for (; i <=len; i++) {
          print(events.documents[i].data);
         var chunk_data = DrawChunk.fromJson(events.documents[i].data);
           
          controller_stream.addChunk(chunk_data);
          
    
        }
    
        
          
        
        
        
        
      });

    
    /*  Firestore.instance
          .collection("users/email/whiteboard")

          ///${event.data['id']}/chdata/cf
          .snapshots()
          .listen((events) {
        //print(events.documentChanges);
        /*var chunk_data = DrawChunk.fromJson(events.data);
        controller_stream.addChunk(chunk_data);*/
      });
      /*Firestore.instance
          .collection("books/${event.data['id']}/chdata")
          //.where("address.country", isEqualTo: "USA")
          .snapshots()
          .listen((result) {
        result.documents.forEach((result) {
          //print(result.data);
          var ch = DrawChunk.fromJson(result.data);
          //print(ds.data);
          setState(() {
            controller_stream.addChunk(ch);
            //print(result.data);
          });
        });
      });*/
    });*/
    /*Firestore.instance.document('qrcode/1').get().then((value) {
      print(value.data['id']);
      
    });*/

    });}
}