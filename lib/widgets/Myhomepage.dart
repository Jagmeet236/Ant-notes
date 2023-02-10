



// import 'dart:html';

// import 'dart:html';
// import 'dart:ui';

import 'package:ant_notes/Firbase_services.dart';
import 'package:ant_notes/widgets/Registe_Screen.dart';
import 'package:ant_notes/widgets/User_page.dart';
import 'package:ant_notes/widgets/googlesingin.dart';
import 'package:ant_notes/widgets/verify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'dart:async';
import 'package:custom_floating_action_button/custom_floating_action_button.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  FirebaseServices services = FirebaseServices();
  User?user = FirebaseAuth.instance.currentUser;
  final EmailController = TextEditingController();
  final passwordController= TextEditingController();
  final _formKey=GlobalKey<FormState>();
  bool isPasswordVisible=true;
  showSnackBar(String snackText, Duration d)
  {

    final snackBar = SnackBar(content: Text(snackText),duration: d,backgroundColor: Colors.pinkAccent, behavior: SnackBarBehavior.floating,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
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
                  height: 560,
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
  child:   Text('Sign In',style: TextStyle(color: Colors.black,letterSpacing: 1.5,fontSize: 30,fontFamily:'Merriweather-Regular',fontWeight: FontWeight.w300,  shadows: [
      Shadow(
      blurRadius: 10.0,
      color: Colors.black,
      offset: Offset(5.0, 5.0),),]
),)),
 SizedBox(height: 25,),
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
                              // scrollPadding: EdgeInsets.only(bottom:40),
                              decoration: InputDecoration(
labelText: 'Email Id',
                                contentPadding: EdgeInsets.all(0.0),
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
SizedBox(height: 15),
                          Container(
                            child: RaisedButton ( onPressed: () async
                            {
                              // var docId =DateTime.now().millisecondsSinceEpoch.toString();

                                await FirebaseAuth.instance.signInWithEmailAndPassword(
                                    email: EmailController.text,
                                    password: passwordController.text).then((value) =>
                                {
                                  services.getuserId(value.user!.uid).then((value) => {

                                    Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => User_profile())),
                                        // EasyLoading.showSuccess("Welcome\n"+value['Email'])
                                showSnackBar('Welcome!\n'+value['UID'], Duration(milliseconds:10000))



                                      // showSnackBar('User Dose Not Exist !', Duration(milliseconds:1000))
                                      }
                                  )



                                });

                            },
                              textColor: Colors.white,
                              color: Colors.pinkAccent,
                            child: Text('Sign In',style: TextStyle(letterSpacing: 1.5,fontWeight: FontWeight.w300,fontFamily:'Merriweather' ),),
                          )
                          ),
                          SizedBox(height: 15,),
                          Text('OR'),
                          SizedBox(height: 15,),
                          Container(
                            height: 40,
                            child: Center(

                              child: FloatingActionButton.extended (onPressed: ()
                              {
                                loginWithGoogle(context);

                              },
                                  backgroundColor: Colors.white,

                                  // icon: Icon(Icons.add),
                                  label:Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [

                                        CircleAvatar(radius: 20, backgroundColor:Colors.white,child: Image(height: 20,
                                          image: AssetImage('assets/google1.png'),)),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0,top: 12),
                                          child: Text('Google Sign In',style: TextStyle(color: Colors.grey,letterSpacing: 1.5),),
                                        )
                                      ]
                                  ) ),


                            ),
                          ),

                          SizedBox(height: 30,),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [



                              Text("Does Not Have An Account  ",style: TextStyle(fontWeight: FontWeight.w300,fontFamily:'Merriweather',color: Colors.black ),),

                              TextButton(onPressed: (){
                                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>verifyemail()));

                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (BuildContext context) => Register()));

                              },child: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.w300,fontFamily:'Merriweather',color: Colors.pinkAccent,letterSpacing: 1,
                              ),),)
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
Future loginWithGoogle(context)async{

  final googleSignIn = GoogleSignIn(scopes: ['email']);
  try{
    final googleSignInAccount = await googleSignIn.signIn();
    if(googleSignInAccount==null)
    {
      // setState(() {
      //   loading=false;
      // });
      return;
    }
    final googleSignInAuthentication = await googleSignInAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) => {
      if(value!=null)
        {
          services. getuserId(value.user!.uid).then((snapshot) async =>{
            if(snapshot.exists)
              {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>User_profile()), (route) => false),
              }
            else
              {
                _createUser(  googleSignInAccount.email, value.user!.uid, googleSignInAccount.displayName, googleSignInAccount.photoUrl, ),
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>User_profile()), (route) => false),
              }
          })
        }
    });

  }on FirebaseAuthException catch(e){
    var content='';
    switch(e.code){
      case 'account-exists-with-different-credential':
        content='This is account exists with different sign in provider';
        break;
      case 'invalid-credential':
        content='Unknown error has occurred';
        break;
      case 'operation-not-allowed':
        content='This operation is not allowed';
        break;
      case 'user-disabled':
        content='The user you tried to log into is disabled';
        break;
      case 'user-not-found':
        content='The user you tried to log into is not found';
        break;

    }
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text('Log in with google failed'),
      content: Text(content),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Ok'))
      ],
    ));
  }catch(e){



  }finally{

  }
}
void _createUser( email,uid,name,Url)async{
  await FirebaseFirestore.instance.collection('User').doc(uid).set({
    'UID':uid,
    'Email':email,
    'Display_name': name,
    'profile': Url,
    'Address':"",
    'Number':""
  });
}