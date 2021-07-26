import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/total.dart';
import 'package:flutter_application_1/screens/cart.dart';
import 'package:flutter_application_1/screens/contactus.dart';

import 'package:flutter_application_1/services/authmanagement.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'empty.dart';
import 'item_page.dart';

class Home extends GetWidget<FirebaseController> {
  //const Home({Key? key}) : super(key: key);

  // here you write the codes to input the data into firestore
  @override
  Widget build(BuildContext context) {
    String? userid = getuserid();
    Get.put(totalvaluecontroller());
    //Get.put(Controller());
    //printdetails();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
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
                    Get.to(contactus());
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
          backgroundColor: Colors.black87,
          title:Text('Clutch Closet',style: TextStyle(fontSize: 20),),
          centerTitle: true,
          actions: [
           // Center(child:Text('Where Style meets Perfection')),
            IconButton(
              onPressed: () async {
                String custom_uid =
                                          controller
                                              .firebaseUser
                                              .value!
                                              .uid;
                final snapShot = await FirebaseFirestore
                    .instance
                    .collection("User_Carts")
                    .doc(
                        custom_uid.trim()) //user id is gonna be id for documents
                    .get();

                if (snapShot.exists) {
                  Get.to(appcart());
                } else {
                  Get.to(empty_page());
                }
              },
              icon: Icon(Icons.shopping_bag_outlined),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 20.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Products")
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return SpinKitFadingCircle(
                      color: Colors.black45);
                default:
                  return new GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 20.0,
                              childAspectRatio: 0.75),
                      itemBuilder: (BuildContext context,
                          int index) {
                        return ItemCard(
                          product:
                              snapshot.data!.docs[index],
                          /*press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>DetailsScreen(
                                product: snapshot.data!.docs[index],
                              ),
                            )),*/
                        );
                      });
              }
            },
          ),
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

/*void printdetails() {
  print("ok");
  print(ProductsController().models);
}*/

class ItemCard extends StatelessWidget {
  final DocumentSnapshot product;
  //final Product product;
  // final Function press;
  const ItemCard({
    required this.product,
    /*required this.product*/
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              product: product,
            ),
          ),
        );
      }, //press(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                color: Color(product[
                    'Colour']), //product['Colour'] is int ,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                //tag: "${product['Name']}",
                child: CachedNetworkImage(
                  placeholder: (context, url) => Center(
                      child: SpinKitWave(
                    color: Colors.white38,
                  )),
                  imageUrl: product['Url'],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 20.0 / 4),
            child: Text(
              // products is out demo list
              product['Brand'],
              style: TextStyle(color: Colors.black87),
            ),
          ),
          Text(
            "\$${product['Price']}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
