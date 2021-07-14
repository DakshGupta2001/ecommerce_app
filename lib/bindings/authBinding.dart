import 'package:flutter_application_1/services/authmanagement.dart';
import 'package:get/get.dart';

class Authbinding extends Bindings {
  @override
  void dependencies() {
   
    Get.lazyPut(() => FirebaseController());
  }
}
