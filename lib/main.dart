import 'package:flutter_application_1/bindings/authBinding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/authmanagement.dart';
import 'package:flutter_application_1/services/productcontroller.dart';
import 'package:flutter_application_1/utils/root.dart';
//import 'package:flutter_application_1/screens/wrapper.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(FirebaseController());
  Get.put(ProductsController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Authbinding(),
      home: Root(),
    );
  }
}


/*
class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            // we will give media query height
            // double.infinity make it big as my parent allows
            // while MediaQuery make it big as per the screen
            
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(
                horizontal: 30, vertical: 50),
            child:SingleChildScrollView(
              child: Column(
                // even space distribution
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                //children: <Widget>[Text("fkdlsa",style: TextStyle(fontSize: 500),)],
               
                 children: <Widget>[
                  Column(
                    
                    children: <Widget>[
                      Text(
                        "Welcome",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "We Provide the most comfortable shoes in the World! ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                  Container(
                    height:
                        MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/welcome.png"))),
                  ),
                      SizedBox(
                        height: 40,
                      ),
                  Column(
                    
                    children: <Widget>[
                      // the login button
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginPage()));
                        },
                        // defining the shape
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.circular(50)),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                      // creating the signup button
                      SizedBox(height: 20),
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignupPage()));
                        },
                        color: Color(0xFF2F332E),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(50)),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ) 
                ], 
              ),
            ),
          ),
        ),
    );
  }
}
*/