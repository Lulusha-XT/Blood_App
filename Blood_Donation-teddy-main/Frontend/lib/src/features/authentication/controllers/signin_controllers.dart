import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/api/api_services.dart';
import 'package:get/get.dart';

class SignInControllers extends GetxController {
  static SignInControllers get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  RxBool isAsyncCallProcess = false.obs;
  RxBool hidePassword = true.obs;

  Future<bool> signInUser(String email, String password) async {
    // AuthenticationRepository.instance.signInUserWithEmailAndPassword(email, password);

    bool result = await ApiService.loginUser(email, password);
    isAsyncCallProcess.value = false;
    return result;
  }
}
