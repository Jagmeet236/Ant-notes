import 'dart:async';
import 'dart:ui';
// import 'dart:html';

import 'package:ant_notes/widgets/User_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
class verifyemail extends StatefulWidget {
  const verifyemail({Key? key}) : super(key: key);

  @override
  State<verifyemail> createState() => _verifyemailState();
}

class _verifyemailState extends State<verifyemail> {
    Timer ?timer;
  User?user = FirebaseAuth.instance.currentUser;
  final EmailController = TextEditingController();
  final otpController= TextEditingController();
  final _formKey=GlobalKey<FormState>();



  void initState() {
    // TODO: implement initState
    User?user = FirebaseAuth.instance.currentUser;
    user?.sendEmailVerification();
    timer= Timer.periodic(Duration(seconds: 5),(timer)
    {
      checkemailverified(context);

    });
    EmailController.addListener(() {
      setState(() {

      });
    });
    super.initState();
    otpController.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }
   Future <void> checkemailverified(context)async
   {
     User?user = FirebaseAuth.instance.currentUser;
     await user!.reload();
     if (user.emailVerified){
timer!.cancel();
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>User_profile())).whenComplete(() => showSnackBar('User Verified Sucessfully', Duration(milliseconds: 1000)));
     }
   }

  showSnackBar(String snackText, Duration d)
  {

    final snackBar = SnackBar(content: Text(snackText),duration: d,backgroundColor: Colors.pinkAccent, behavior: SnackBarBehavior.floating,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return Container(decoration: const BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.pinkAccent, Colors.black])),
    child:Scaffold(
    backgroundColor: Colors.transparent,
    body: Form(
    key: _formKey,
    child: Center(

    child:SizedBox(
    height: 500,
    width: 350,

    child: Card(
    child: ClipRRect(
    borderRadius:BorderRadius.circular(20),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    // mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Container(
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: CircleAvatar(
    backgroundColor: Colors.white,
    radius: 50,
    child: Image(image:AssetImage('assets/logo.png')),
    ),
    ),
    ),
      SizedBox(height: 30,),
      Container(
        width: 300,
        padding: EdgeInsets.all(10),

    ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child:Text('An email  verification link has been sent to : ' ,style: TextStyle(fontSize: 15, letterSpacing: 1.5,fontWeight: FontWeight.w500),) ,),
      ),
      SizedBox(height: 12,),
      Center(child: Text('${user!.email}',style: TextStyle(fontSize: 20, letterSpacing: 1.5, color: Colors.pinkAccent,fontWeight: FontWeight.w500),),),
      SizedBox(height: 16,),
      Center(child: Text('Please Verify.',style: TextStyle(fontSize: 15, letterSpacing: 1.5,fontWeight: FontWeight.w500),),),
    ]
    )
    )))))));

  }
}


