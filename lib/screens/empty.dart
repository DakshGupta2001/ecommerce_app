import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class empty_page extends StatelessWidget {
  const empty_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Center(
        child: Text("NO ITEMS"),
      ),
    );
  }
}
