import 'dart:async';
import 'dart:ffi';

import 'package:blood_bank/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../services/app_constant.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  initState(){
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    AppConst.size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              bottom: -80,
                child:SvgPicture.asset('assets/images/wave.svg') ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children:[
                  const SizedBox(height: 100,),
                  const Text('وَمَنْ أَحْيَاهَا فَكَأَنَّمَا أَحْيَا النَّاسَ جَمِيعاً',textAlign: TextAlign.center,style: TextStyle(fontSize: 24),),
                  const SizedBox(height: 20,),
                  Image.asset('assets/images/bloodbank2.png'),
                  const SizedBox(height: 30,),
                  const Text('بنك الدم', style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),),






                ]
            ),
            
          ],
        )
      )
    );
  }
}
