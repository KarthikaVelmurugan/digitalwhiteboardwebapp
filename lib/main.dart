import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whiteboard/animation_delay.dart';
import 'package:whiteboard/homescreen.dart';
import 'package:whiteboard/shared.dart';//animationdelay

import 'theme.dart' as Theme;
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
return MaterialApp(
  title: "Online whiteBoard",
  debugShowCheckedModeBanner: false,
  theme: ThemeData(fontFamily:'Poppins'),
  home: Home(),
);
  }
}
class Home extends StatefulWidget{
  @override 
  _Home createState() => _Home();
}
class _Home extends State<Home>  with SingleTickerProviderStateMixin {

final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;


  
 
                     @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }
  @override 
  Widget build(BuildContext context){
  
     _scale = 1 - _controller.value;

     MediaQueryData queryData = MediaQuery.of(context);
    double ht = queryData.size.height;
    double wt = queryData.size.width;
      
     
    return  Scaffold(
      
        body: Container(
          height: ht,
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
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
   DelayedAnimation(
     child:        
Container(
                        padding: EdgeInsets.all(8.0),
                        height: ht/2.5,
                        width: queryData.size.width,
                        child: Image.asset('assets/login_logo.png',height: ht/5,width: wt/3,),  ),
                        delay: delayedAmount + 1000,) , 
               
Container(
  height: ht/4,
  child:Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children:<Widget>[
    DelayedAnimation(
                  child:  Text(
    "ONLINE WHITE BOARD",style: ts.copyWith(fontSize:wt/40),
  ),
  delay: delayedAmount + 2000,
  ),
 DelayedAnimation(
    child:
  Text(
    "We need to bring learning to people instead of people to learning",style:ts1.copyWith(fontSize: wt/60)),
    delay: delayedAmount + 3000,),
  /*  DelayedAnimation(
      child:
    Text("instead of people to learning",style: ts1,
  ),
  delay: delayedAmount + 4000,), ])),*/
    ])),
 DelayedAnimation(
   child:Padding(
                        padding: EdgeInsets.all(10),
                        child:Container(                               
                        child:_startButton(wt)
                          
                          
                        ) ),
                        delay: delayedAmount + 5000,)

        ],),
      ),
      );
     
  }

    Widget _startButton(double wt) {
            return OutlineButton(
              onPressed: () async {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                  return HomePage();
                }));
               
                //    toast(context,"Successfully signin your google account!");
                
      
          
                 
              },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              highlightElevation: 0,      
              borderSide: BorderSide(color: Colors.white70,width: 2),
              child: Padding(        
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: 
                      Text(
                    "Let's Start",
                    style:btnstyle.copyWith(fontSize:wt/50),
                  ),
                   ),
              ),
              );
}
}