import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';




import 'package:flutter/material.dart';
class FirebaseServices
{
  Future<DocumentSnapshot> getUserDetails(id) async{
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("User").doc(id).get();
    return doc;
  }
  Future<void>deleteUser(id)async
  {
    await FirebaseFirestore.instance.collection("User").doc(id).delete();
    await FirebaseAuth.instance.currentUser!.delete();
  }
  Future <DocumentSnapshot> getuserId(id)async{
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("User").doc(id).get();
    return doc;
  }
  }
