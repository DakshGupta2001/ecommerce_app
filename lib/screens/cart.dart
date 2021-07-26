import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/total.dart';
import 'package:flutter_application_1/screens/payment.dart';
import 'package:flutter_application_1/services/authmanagement.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class appcart extends StatefulWidget {
  appcart({Key? key}) : super(key: key);

  @override
  _appcartState createState() => _appcartState();
}

class _appcartState extends State<appcart> {
  @override
  Widget build(BuildContext context) {
    int total = 0;
    //bool all_items = false;
    totalvaluecontroller valuecontroller = Get.find();
    FirebaseController controller = Get.find();
    String custom_uid = controller.firebaseUser.value!.uid;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Your Cart",
          
        ),
        backgroundColor: Colors.black87,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            }),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20.0, vertical: 20.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("User_Carts")
              .doc(custom_uid.trim())
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return SpinKitFadingCircle(
                    color: Colors.black45);
              default:
                total = snapshot.data!['Cart_value'];
                return new ListView.builder(
                    itemCount:
                        snapshot.data!['Items'].length,
                    itemBuilder:
                        (BuildContext context, int index) {
                      return Dismissible(
                          direction:
                              DismissDirection.horizontal,
                          key: Key(snapshot.data!['Items']
                                  [index]
                              .trim()),
                          child: itemtile(
                            productid: snapshot
                                .data!['Items'][index],
                            custom_uid: custom_uid,
                            index: index,
                          ),
                          onDismissed: (direction) async {
                            //DocumentSnapshot variable =
                            var ans = 0;
                            var document = FirebaseFirestore
                                .instance
                                .collection('Products')
                                .doc(snapshot.data!['Items']
                                    [index]);
                            print(document);
                            var result =
                                await document.get();

                            Map<String, dynamic>? data =
                                result.data();
                            ans = data?['Price'];

                            setState(() {
                              /* var ans = variable.data();
                              print(ans);
                              print('hello');*/
                              FirebaseFirestore.instance
                                  .collection("User_Carts")
                                  .doc(custom_uid.trim())
                                  .update({
                                "Items":
                                    FieldValue.arrayRemove([
                                  snapshot.data!['Items']
                                          [index]
                                      .trim()
                                ]),
                                "Cart_value":
                                    snapshot.data![
                                            'Cart_value'] -
                                        ans,
                              });
                            });
                          });
                    });
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(
              height: 60,
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("User_Carts")
                    .doc(custom_uid.trim())
                    .delete()
                      ..then((_) => print('Deleted'))
                          .catchError((error) => print(
                              'Delete failed: $error'));
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) =>
                          paymentmethod(total: total)),
                );
              },
              child: totaldisplaer(custom_uid: custom_uid),
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15.0)),
            ),
          )),
    );
  }
}

class itemtile extends StatelessWidget {
  final String productid;
  final String custom_uid;
  final int index;
  const itemtile(
      {required this.productid,
      required this.custom_uid,
      required this.index});

  @override
  Widget build(BuildContext context) {
    totalvaluecontroller valuecontroller = Get.find();
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Products")
            .doc(productid.trim())
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          /*else if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }*/
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SpinKitFadingCircle(
                  color: Colors.black45);
            default:
              /*valuecontroller.total =
                  valuecontroller.total +
                      (snapshot.data!["Price"] as int);*/

              return Card(
                elevation: 20.0,
                color: Color(snapshot.data!['Colour']),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        width: 50.0,
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              Center(
                                  child: SpinKitWave(
                            color: Colors.white38,
                          )),
                          imageUrl: snapshot.data!['Url'],
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(snapshot.data?['Brand']),
                      Spacer(),
                      Column(
                        children: <Widget>[
                          SizedBox(height: 25),
                          Text(
                              "\$${snapshot.data?['Price']}"),
                        ],
                      )
                    ],
                  ),
                ),
              );
          }
        });
  }
}

late _totaldisplayerState displaystate;

class totaldisplayer extends StatefulWidget {
  //bool all_items;
  totaldisplayer({
    Key? key,
  }) : super(key: key);

  @override
  _totaldisplayerState createState() {
    displaystate = _totaldisplayerState();
    return displaystate;
  }
}

class _totaldisplayerState extends State<totaldisplayer> {
  @override
  Widget build(BuildContext context) {
    totalvaluecontroller valuecontroller = Get.find();

    return Text("${valuecontroller.total}");
  }
}

class totaldisplaer extends StatelessWidget {
  final String custom_uid;
  const totaldisplaer({Key? key, required this.custom_uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late int total;
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("User_Carts")
            .doc(custom_uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SpinKitFadingCircle(
                  color: Colors.black45);
            default:
              total = snapshot.data!['Cart_value'];
              return Text(
                "Checkout: \$$total",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              );
          }
        });
  }
}
/*
 final snapshot = await FirebaseFirestore.instance
        .collection("User_Carts")
        .doc(custom_uid)
        .get();
    if (snapshot.exists) {
      int value_to_display = snapshot.data()!["Cart_value"];
      return Text("$value_to_display");
    } else {
      return Text("NO ITEMS");
    }
    */

class costgiver {
  int getmoney(String id) {
    return 2;
  }
}
