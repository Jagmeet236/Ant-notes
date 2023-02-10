

// import 'dart:html';

// import 'dart:html';

import 'package:ant_notes/widgets/Myhomepage.dart';
import 'package:ant_notes/widgets/verify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  User?user = FirebaseAuth.instance.currentUser;
  final EmailController = TextEditingController();
  final passwordController= TextEditingController();
  final _formKey=GlobalKey<FormState>();
  bool isPasswordVisible=true;
  void initState() {
    // TODO: implement initState
    EmailController.addListener(() {
      setState(() {

      });
    });
    super.initState();
    passwordController.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }
  showSnackBar(String snackText, Duration d)
  {

    final snackBar = SnackBar(content: Text(snackText),duration: d,backgroundColor: Colors.pinkAccent, behavior: SnackBarBehavior.floating,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
// SizedBox(height: 10,),

                      Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child:   Text('Sign Up',style: TextStyle(color: Colors.black,letterSpacing: 1.5,fontSize: 30,fontFamily:'Merriweather-Regular',fontWeight: FontWeight.w300,  shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(5.0, 5.0),),]
                          ),)),
                      SizedBox(height: 30,),
                      Container(
                        width: 300,
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if(value!.isEmpty)
                            {
                              return 'please fill the form';
                            }

                            bool check=EmailValidator.validate(EmailController.text);
                            if(!check==true)
                            {
                              return 'please enter valid email id';
                            }
                            setState(() {
                              value=EmailController.text;
                            });
                            return null;
                          },
                          controller: EmailController,
                          decoration: InputDecoration(
                            labelText: 'Email Id',
                            // hintText: 'demo@gmail.com',
                            prefixIcon: Icon(Icons.mail),
                            fillColor: Colors.black,
                            suffixIcon: EmailController.text.isEmpty ? Container(width: 0,):IconButton(onPressed: ()=>EmailController.clear(), icon:Icon(Icons.close)),

                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Container(
                        width: 300,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          validator:(value){
                            if(value!.isEmpty)
                            {
                              return 'please fill this form';
                            }
                            else if(value.length>8)
                            {
                              return "minimum value is 8" ;
                            }
                            // bool check=PasswordValidator().validate(password);
                            // if(!check==true)
                            // {
                            //   return 'please enter valid password ';
                            // }

                            setState(() {
                              value= passwordController.text;
                            });
                            return null;
                          },

                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: 'Password..',
                            labelText: 'Password',
                            // errorText: 'Password is wrong',
                            prefixIcon: Icon(Icons.security),
                            suffixIcon:IconButton(
                                onPressed: (){
                                  setState(() {
                                    isPasswordVisible=!isPasswordVisible;
                                  });
                                },
                                icon:isPasswordVisible?Icon(Icons.visibility_off):Icon(Icons.visibility)

                            ),

                          ),
                          obscureText: isPasswordVisible,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                          child: RaisedButton ( onPressed: () async
                          {
                            var docId =DateTime.now().millisecondsSinceEpoch.toString();
                            try{
                             await FirebaseAuth.instance.createUserWithEmailAndPassword(email: EmailController.text, password: passwordController.text).then((value) =>
                            {
                              FirebaseFirestore.instance.collection('User')
                                  .doc(value.user!.uid).set({
                                'UID': value.user!.uid,
                                'Email': EmailController.text,
                                'Password': passwordController.text,

                              })
                                  .whenComplete(() =>
                              {

                                EmailController.clear(),
                                passwordController.clear(),
Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>verifyemail()))

                              })
                            });
                          }
                          catch(e)
                            {

                              showSnackBar( e.toString(), Duration(milliseconds:1000));
                            }
                          },
                            textColor: Colors.white,
                            color: Colors.pinkAccent,
                            child: Text('Sign Up',style: TextStyle(letterSpacing: 1.5,fontWeight: FontWeight.w300,fontFamily:'Merriweather' ),),
                          )
                      ),
                      SizedBox(height: 15,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [



                          Text("Have An Account ? ",style: TextStyle(fontWeight: FontWeight.w300,fontFamily:'Merriweather',color: Colors.black ),),

                          TextButton(onPressed: (){

                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (BuildContext context) => MyHomeScreen()));
                          },child: Text('Sign In',style: TextStyle(fontWeight: FontWeight.w300,fontFamily:'Merriweather',color: Colors.pinkAccent,letterSpacing: 1,
                              ),))
                        ],
                      )
                    ],
                  ),

                ),
              ),

            ),

          ),
        ),


      ) ,
    );
  }
}
