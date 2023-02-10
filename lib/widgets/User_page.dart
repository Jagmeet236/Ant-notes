




import 'dart:io';
// import 'dart:ui';

import 'package:ant_notes/Firbase_services.dart';
import 'package:ant_notes/widgets/Myhomepage.dart';
import 'package:ant_notes/widgets/User_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:firebase_auth/firebase_auth.dart';
// Stream demo =FirebaseFirestore.instance.collection('User').where('UID',isEqualTo: user!.uid).snapshots();
FirebaseServices services=FirebaseServices();

Future <DocumentSnapshot> getuserId(id)async{
  User? user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot doc = await FirebaseFirestore.instance.collection("User").doc(id).get();
  return doc;
}

final _formKey=GlobalKey<FormState>();
class User_profile extends StatefulWidget {
  const User_profile({Key? key}) : super(key: key);

  @override
  State<User_profile> createState() => _User_profileState();
}

class _User_profileState extends State<User_profile> {
  final _textController=TextEditingController();

  final subController=TextEditingController();

  showSnackBar(String snackText, Duration d)
  {

    final snackBar = SnackBar(content: Text(snackText),duration: d,backgroundColor: Colors.pinkAccent, behavior: SnackBarBehavior.floating,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
  User? user = FirebaseAuth.instance.currentUser;
  String? id;
  void initState() {
    // TODO: implement initState
    id = user!.uid;
    _textController.addListener(() {
      setState(() {

      });
    });
    super.initState();

  }
  void ini2tState() {
    // TODO: implement initState
    subController.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar:AppBar(
  backgroundColor: Colors.white,
  centerTitle: true,
  flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black, Colors.pinkAccent],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft))),
  title: Text('Ant Notes',style: TextStyle(letterSpacing: 1.5,fontWeight: FontWeight.w300,fontFamily:'Merriweather',color: Colors.white ),),
  actions: [
    IconButton(onPressed: () async{
      await FirebaseAuth.instance.signOut().whenComplete(() => {  Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => MyHomeScreen(),
        ),
            (Route<dynamic> route) => false,
      )});


    }, icon: Icon(Icons.logout))
  ],
),
      body: StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection('User').where('UID',isEqualTo: id).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
    return Text('Something went wrong');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
    return Text("Loading");
    }

      return ListView(
        physics: BouncingScrollPhysics(),
        children:
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Column(
                  children: [
                    Container(

                      height: 120,
                      width: MediaQuery.of(context).size.width,


                        child:(data['Title']!= null)? Card(

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 18.0,left: 8),
                                  child: Text(data['Title'], style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,letterSpacing: 1,),)

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:10, left: 8),
                                  child: Text(data['Subscription'], style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,letterSpacing: 1,),)

                                ),
Row(
  mainAxisAlignment: MainAxisAlignment.end,
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
    Container(child:  IconButton(
        icon: Icon(
          Icons.clear,
        ),
        iconSize: 30,
        color: Colors.pinkAccent,
        splashColor: Colors.purple[100],
        onPressed: ()async
        {
          // var docId =DateTime.now().millisecondsSinceEpoch.toString();
         await FirebaseFirestore.instance.collection('User').doc(data['DOCID']).delete();
        },
    )

    )
  ],
)
                              ],
                            )

                        ):Container(child: Image(
height: 200,
                          width: MediaQuery.of(context).size.width,
                          image: AssetImage('assets/logo.png'),),),



                      ) ,




                    ]) );
        }).toList(),
      );






    },
      ),

    floatingActionButton: FloatingActionButton(
            onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>todotext()));
      showDialog(context: context,

        builder:(context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),


            ),


            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 5,),
              child: Form(
                key: _formKey,
                child: ListView(
                    shrinkWrap: true,
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
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(

                          child: SizedBox
                            (



                            child: TextFormField(
                              validator: (value) {
                                if (value == Null) {
                                  return 'please fill the form';
                                }
       setState(() {
    value=_textController.text;
    });
    return null;
    },

                              controller: _textController,
                              maxLines: 2,
                              decoration: InputDecoration(
                                labelText: 'Title',
                                suffixIcon: _textController.text.isEmpty ? Container(width: 0,):IconButton(onPressed: ()=>_textController.clear(), icon:Icon(Icons.close)),
                                labelStyle:
                                TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 22,
          letterSpacing: 1.5,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline),
                                focusColor: Colors.black,

                                //
                                focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          ),

                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(

                          child: SizedBox
                            (

                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please fill the form';
                                }
                                setState(() {
                                  value=subController.text;
                                });
                                return null;
                              },
                              controller: subController,
                              // maxLines: 2,
                              decoration: InputDecoration(
                                labelText: 'Subscription',
                                suffixIcon: subController.text.isEmpty ? Container(width: 0,):IconButton(onPressed: ()=>subController.clear(), icon:Icon(Icons.close)),
                                labelStyle:
                                TextStyle(
                                    color: Colors.pinkAccent,
                                    fontSize: 22,
                                    letterSpacing: 1.5,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline),
                                focusColor: Colors.black,

                                //
                                focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                              ),

                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),

                      TextButton(onPressed: ()
                     async {
try{
  var docId =DateTime.now().millisecondsSinceEpoch.toString();
  User?user = FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance.collection("User").doc(docId).set(

      {

        'UID':user!.uid,
        'Title':_textController.text,
        'Subscription':subController.text,
        'DOCID': docId

      }).then((value) => {
    print("data stored successfully"),
    _textController.clear(),
    subController.clear(),
    Navigator.of(context).pop()
  });}
    catch (e){

  showSnackBar('Empty Tabs'+e.toString(), Duration(milliseconds: 1000));
    }

                      }
                      ,child: Text('GO',style: TextStyle(fontWeight: FontWeight.w300,fontFamily:'Merriweather',color: Colors.pinkAccent,letterSpacing: 1,
                      ),),)



                    ]),
              ),

            ),


          );
        } );
            },

          backgroundColor: Colors.pink,
child: Icon(Icons.add_task),

        )

    );
  }
}
