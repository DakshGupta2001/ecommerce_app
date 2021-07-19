import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/authmanagement.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class appcart extends StatefulWidget {
  appcart({Key? key}) : super(key: key);

  @override
  _appcartState createState() => _appcartState();
}

class _appcartState extends State<appcart> {
  @override
  Widget build(BuildContext context) {
    FirebaseController controller = Get.find();
    String custom_uid = controller.firebaseUser.value!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
              .doc(custom_uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } /*else if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }*/
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return SpinKitFadingCircle(
                    color: Colors.black45);
              default:
                return new ListView.builder(
                  itemCount: snapshot.data!['Items'].length,
                  itemBuilder:
                      (BuildContext context, int index) {
                    return itemtile(
                      productid: snapshot.data!['Items']
                          [index],
                      custom_uid: custom_uid,
                    );
                  },
                );
            }
          },
        ),
      ),
      
    );
  }
}

class itemtile extends StatelessWidget {
  final String productid;
  final String custom_uid;
  const itemtile(
      {required this.productid, required this.custom_uid});

  @override
  Widget build(BuildContext context) {
    Future k = FirebaseFirestore.instance
        .collection("Products")
        .doc(productid)
        .snapshots()
        .length;
    print(productid.trim());
    print(k);
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
             return Card(
            elevation: 20.0,
            color: Color(snapshot.data!['Colour']),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)) ,
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                   Container(
                      height: 50.0,
                      width: 50.0,
                      
                      child:CachedNetworkImage(
              placeholder: (context, url) => Center(
                  child: SpinKitWave(
                color: Colors.white38,
              )),
              imageUrl: snapshot.data!['Url'],
            ),
          ),
          SizedBox(width: 10.0,),
          Text(snapshot.data?['Brand']),
                ],
              ),

              
            ),
          );
          }
        });
  }
}
