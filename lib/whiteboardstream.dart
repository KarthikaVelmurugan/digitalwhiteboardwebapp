import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whiteboardkit/sketch_stream_controller.dart';
import 'package:whiteboardkit/whiteboardkit.dart';

class WhiteBoardStream extends StatefulWidget {
  String random;
  WhiteBoardStream({this.random});
  @override
  _WhiteBoardStreamState createState() => _WhiteBoardStreamState();
}

class _WhiteBoardStreamState extends State<WhiteBoardStream> {
  //create controller for whiteboard widget
  SketchStreamController controller_stream;

  String email;
  bool live;
  @override
  void initState() {
    controller_stream = new SketchStreamController();
    //get chunk of data from mobile { Get chunkdata on mobile app whiteboard}
    getChunk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dynamic ratio = MediaQuery.of(context).size.aspectRatio;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    double height = size.height;
    double width = size.width;
    setState(() {
      controller_stream.initializeSize(width * 2.3, height * 3);
    });

    // controller_stream.initializeSize(height, width);
    print("The ratio " + ratio.toString());

    Firestore.instance
        .collection('qrcode')
        .document(widget.random)
        .snapshots()
        .listen((event) {
      print(event.data['email']);
      email = event.data['email'];
      live = event.data['live'];
      print(live);
    });
    return Padding(
        padding: EdgeInsets.only(top: 100, bottom: 100, left: 10, right: 10),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Whiteboard(
                controller: controller_stream,
              ),
            )
          ],
        )));
  }

  @override
  void dispose() {
    Firestore.instance.collection('qrcode').getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
    controller_stream.close();
    super.dispose();
  }

  void getChunk() {
    print("widget.random" + widget.random);
    //get chunk data from mobile app whiteboard
    Firestore.instance
        .collection('qrcode')
        .document(widget.random)
        .snapshots()
        .listen((event) {
      print(event.data['email']);
      email = event.data['email'];

      Firestore.instance
          .collection('users')
          .document(email)
          .collection('whiteboard')
          .snapshots()
          .listen((events) {
        print("length:");
        print(events.documents.length);
        var len = events.documents.length;

        var i = 0;
        for (; i <= len; i++) {
          print(events.documents[i].data);
          var chunk_data = DrawChunk.fromJson(events.documents[i].data);

          controller_stream.addChunk(chunk_data);
        }
      });
    });
  }
}
