import 'package:ant_notes/widgets/Myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'User_page.dart';
class Slpash_Screen extends StatefulWidget {
  const Slpash_Screen({Key? key}) : super(key: key);

  @override
  State<Slpash_Screen> createState() => _Slpash_ScreenState();
}

class _Slpash_ScreenState extends State<Slpash_Screen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 5), (){
      FirebaseAuth.instance.authStateChanges().listen((user) async
      {
        if (user == null) {
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (_) => MyHomeScreen()), (
              route) => false);

        }
        else
        {
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (_) => User_profile()), (
              route) => false);

        }
      });
    }
    );

    super.initState();
  }
  Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(

      body: Container(
        height:double.infinity,
        width: double.infinity,
        child: Image(image: AssetImage('assets/logo.png')),
      ),

    ),
  );
  }
}
