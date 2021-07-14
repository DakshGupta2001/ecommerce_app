import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/usermodel.dart';

import 'package:get/get.dart';

class FirebaseController extends GetxController {
  //initialising auth ie instance of firebaseauth
  FirebaseAuth _auth = FirebaseAuth.instance;
  //user type firebaseUser
  Rxn<User> firebaseUser =
      Rxn<User>(); //makes it observable with null values
  //gets condition of user
  String? get user =>
      firebaseUser.value?.email; //can be null

  //whenever stream is available it is called and binds the stream which triggers the get user
  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  void createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      AuthUser().authmethod(
          email); //to get the email of signed in user
      Get.back(); //close progress bar
      Get.back();
    } catch (e) {
      Get.back();
      Get.snackbar(
        "error creating abbount",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      //CircularProgressIndicator();
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      AuthUser().authmethod(email);
      //print(AuthUser().email);
      Get.back(); //close progress bar
      Get.back(); //close page
    } catch (e) {
      Get.back(); //close the bar
      //print("the heck u think u doing");
      Get.snackbar(
        "error logging into account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signout() async {
    await _auth.signOut();
  }
}
