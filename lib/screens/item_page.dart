import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/total.dart';
import 'package:flutter_application_1/services/authmanagement.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  final DocumentSnapshot product;
  const DetailsScreen({required this.product});
  //@override
void initState(){
  //super.initState();
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
  ]);
}
//@override
dispose(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //super.dispose();
}
  @override
  Widget build(BuildContext context) {
    FirebaseController controller = Get.find();
    totalvaluecontroller valuecontroller = Get.find();
    return Scaffold(
      // each product have a color
      backgroundColor: Color(product['Colour']),
      appBar: AppBar(
        backgroundColor: Color(product['Colour']),
        elevation: 0,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context)
                                .size
                                .height *
                            0.33),
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context)
                              .size
                              .height *
                          0.12,
                      left: 20.0,
                      right: 20.0,
                    ),
                    // height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 7.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: <Widget>[
                                  Text("Color"),
                                  Row(
                                    children: <Widget>[
                                      ColorDot(
                                        color: Color(
                                            product[
                                                'Colour']),
                                        isSelected: true,
                                      ),
                                      ColorDot(
                                          color: Color(
                                              0xFFF8C078)),
                                      ColorDot(
                                          color: Color(
                                              0xFFA29B9B)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color:
                                          Colors.black87),
                                  children: [
                                    TextSpan(
                                        text: "Size\n"),
                                    TextSpan(
                                      text: " 20 cm",
                                      style: Theme.of(
                                              context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              fontWeight:
                                                  FontWeight
                                                      .bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0 / 2),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                  vertical: 20.0),
                          child: Text(
                            product['Description'],
                            style: TextStyle(height: 1.5),
                          ),
                        ),
                        SizedBox(height: 20.0 / 2),
                        //CounterWithFavBtn(),
                        // SizedBox(height: 20.0 / 2),
                        //AddToCart(product: product)
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: <Widget>[
                            Cartcounter(),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(8),
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  color: Color(
                                      product['Colour']),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                    CupertinoIcons.heart),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.0 / 2),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                  vertical: 20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    right: 20.0),
                                height: 50,
                                width: 58,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(
                                          18),
                                  border: Border.all(
                                    color: Color(
                                        product['Colour']),
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                      CupertinoIcons.cart),
                                  color: Color(
                                      product['Colour']),
                                  onPressed: () {},
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  // ignore: deprecated_member_use
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius
                                                .circular(
                                                    18)),
                                    color: Color(
                                        product['Colour']),
                                    onPressed: () async {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Item Added To Cart",
                                          toastLength: Toast
                                              .LENGTH_SHORT,
                                          gravity:
                                              ToastGravity
                                                  .TOP,
                                          timeInSecForIosWeb:
                                              1,
                                          backgroundColor:
                                              Colors.black54,
                                          textColor:
                                              Colors.white,
                                          fontSize: 16.0);

                                      String custom_uid =
                                          controller
                                              .firebaseUser
                                              .value!
                                              .uid;

                                      final snapShot =
                                          await FirebaseFirestore
                                              .instance
                                              .collection(
                                                  "User_Carts")
                                              .doc(
                                                  custom_uid) //user id is gonna be id for documents
                                              .get();

                                      if (!snapShot
                                          .exists) {
                                        //if document id exists add onto it else make a new one

                                        FirebaseFirestore
                                            .instance
                                            .collection(
                                                "User_Carts")
                                            .doc(custom_uid)
                                            .set({
                                          "Items": FieldValue
                                              .arrayUnion([
                                            product["Id"].trim()
                                          ]),
                                          "Cart_value":
                                              (product[
                                                      "Price"]
                                                  as int)
                                        });
                                      } else {
                                        FirebaseFirestore
                                            .instance
                                            .collection(
                                                "User_Carts")
                                            .doc(custom_uid)
                                            .update({
                                          "Items": FieldValue
                                              .arrayUnion([
                                            product["Id"].trim()
                                          ])
                                        });
                                        int prev_cart_val =
                                            snapShot.data()![
                                                'Cart_value'];
                                        FirebaseFirestore
                                            .instance
                                            .collection(
                                                "User_Carts")
                                            .doc(custom_uid)
                                            .update({
                                          "Cart_value": (product[
                                                      'Price']
                                                  as int) +
                                              prev_cart_val
                                        });
                                      }
                                      /*
                                                try{
                                        FirebaseFirestore
                                            .instance
                                            .collection(
                                                "User_Carts")
                                            .doc(custom_uid)
                                            .update({
                                          "Items": FieldValue
                                              .arrayUnion([
                                            product["Id"]
                                          ])
                                        });
                                                }
                                                on FirebaseException
                                                {
                                                  print(custom_uid);
                                          FirebaseFirestore
                                              .instance
                                              .collection(
                                                  "User_Carts")
                                              .doc(custom_uid)
                                              .set({
                                            "Items": FieldValue
                                                .arrayUnion([
                                              product["Id"]
                                            ])
                                          });
                                                }
                                      */
                                    },
                                    child: Text(
                                      "Add to Cart"
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight:
                                            FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Aristocrated Handbags",
                          style: TextStyle(
                              color: Colors.white),
                        ),
                        Text(
                          product['Brand'],
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight:
                                      FontWeight.bold),
                        ),
                        //SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: "Price\n"),
                                  TextSpan(
                                    text:
                                        "\$${product['Price']}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            color: Colors
                                                .white,
                                            fontWeight:
                                                FontWeight
                                                    .bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Expanded(
                              child: Container(
                                child: CachedNetworkImage(
                                  imageUrl: product['Url'],
                                  fit: BoxFit.fill,
                                  placeholder: (context,
                                          url) =>
                                      CircularProgressIndicator(),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const ColorDot({
    required this.color,
    // by default isSelected is false
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20.0 / 4,
        right: 20.0 / 2,
      ),
      padding: EdgeInsets.all(2.5),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? color : Colors.transparent,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class Cartcounter extends StatefulWidget {
  Cartcounter({Key? key}) : super(key: key);

  @override
  _CartcounterState createState() => _CartcounterState();
}

class _CartcounterState extends State<Cartcounter> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0 / 2),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
              });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton(
      {required IconData icon, required Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      // ignore: deprecated_member_use
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: () => press(),
        child: Icon(icon),
      ),
    );
  }
}
/*
class CartCOUNTER extends StatelessWidget {
  const CartCOUNTER({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.find();
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (c.count > 1) {
              c.decrement();
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0 / 2),
          child: Obx(
            () => Text(
              // if our item is less  then 10 then  it shows 01 02 like that
              c.count.toString().padLeft(2, "0"),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              c.increment();
            }),
      ],
    );
  }

  SizedBox buildOutlineButton(
      {required IconData icon, required Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      // ignore: deprecated_member_use
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: () => press(),
        child: Icon(icon),
      ),
    );
  }
}

class Controller extends GetxController {
  var count = 1.obs;
  increment() => count++;
  decrement() => count--;
}
*/
