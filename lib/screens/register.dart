import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/authmanagement.dart';
import 'package:get/get.dart';

class SignupPage extends GetWidget<FirebaseController> {
  final TextEditingController emailcontroller =
      TextEditingController();
  final TextEditingController passwordcontroller =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height ,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create an account, It's free ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700]),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 20,
                margin: EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Username",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                
                            obscureText: false,
                            
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200], filled: true,
                              focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black, width: 2.0),),
                                prefixIcon: Icon(Icons.account_box_rounded,color: Colors.black,),
                                contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 3,
                                        horizontal: 10),
                                /*enabledBorder:
                                    OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .grey.shade400),
                                ),*/
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black,),
                                        borderRadius: BorderRadius.circular(20),),
                        
                                        ),
                                            
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: emailcontroller,
                            obscureText: false,
                            
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200], filled: true,
                              focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black, width: 2.0),),
                                prefixIcon: Icon(Icons.mail_rounded,color: Colors.black,),
                                contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 3,
                                        horizontal: 10),
                      
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black,),
                                        borderRadius: BorderRadius.circular(20),),
                        
                                        ),
                                            
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: passwordcontroller,
                            obscureText: false,
                            
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200], filled: true,
                              focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black, width: 2.0),),
                                prefixIcon: Icon(Icons.lock_open_rounded,color:Colors.black,),
                                contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 3,
                                        horizontal: 10),
                                /*enabledBorder:
                                    OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .grey.shade400),
                                ),*/
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black,),
                                        borderRadius: BorderRadius.circular(20),),
                        
                                        ),
                                            
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Confirm Password",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                    
                            obscureText: false,
                            
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200], filled: true,
                              focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black, width: 2.0),),
                                prefixIcon: Icon(Icons.lock,color: Colors.black,),
                                contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: 3,
                                        horizontal: 10),
                                /*enabledBorder:
                                    OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .grey.shade400),
                                ),*/
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black,),
                                        borderRadius: BorderRadius.circular(20),),
                        
                                        ),
                                            
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom:
                          BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right:
                          BorderSide(color: Colors.black),
                    )),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                        10)),
                            elevation: 30,
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 10,
                                  bottom: 10,),
                                  child:
                                  Column(children: <Widget>[
                                    Text("Loading"),
                                    LinearProgressIndicator(color: Colors.black,backgroundColor: Colors.grey[200],)
                                  ],
                                  ),
          
                            ),
                          );
                        },
                      );
                    controller.createUser(
                          emailcontroller.text, passwordcontroller.text);
                  },
                  color: Color(0xFF2F332E),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height:8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  Text(
                    " Login",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  )
                ],
              ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
