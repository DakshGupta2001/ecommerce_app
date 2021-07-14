import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/usermodel.dart';
import 'package:flutter_application_1/services/authmanagement.dart';
import 'package:flutter_application_1/services/productcontroller.dart';
import 'package:get/get.dart';

class Home extends GetWidget<FirebaseController> {
  //const Home({Key? key}) : super(key: key);

  // here you write the codes to input the data into firestore
  @override
  Widget build(BuildContext context) {
    String? userid = getuserid();
    printdetails();
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.

          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,

            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Text(
                  'Hey there ,$userid',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.mail_outline_rounded),
                  contentPadding:
                      EdgeInsetsDirectional.all(10),
                  title: Text('Contact Us'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.logout_sharp),
                  contentPadding:
                      EdgeInsetsDirectional.all(10),
                  title: Text('Sign Out'),
                  onTap: () {
                    controller.signout();
                  },
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [],
        ),
        body: GridView.builder(
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 20,
            );
          },
        ),
      ),
      //bodyyyyyy
    );
  }
}

String? getuserid() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user!.email;
  return uid!.substring(0, uid.indexOf('@'));
}

void printdetails() {
  print("ok");
  print(ProductsController().models);
}
