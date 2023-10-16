import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/api/api_services.dart';
import 'package:flutter_application_1/src/features/core/models/user_model.dart';
import 'package:get/get.dart';

class SignUpControllers extends GetxController {
  static SignUpControllers get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final phoneNo = TextEditingController();
  final bloodType = TextEditingController();
  RxBool hidePassword = true.obs;
  String defaultValue = 'A+';
  RxBool isAsyncCallProcess = false.obs;

  //final userRepo = Get.put(UserRepository());
  //Call this Function from Design & it will do the rest
  void registerUser(String email, String password) {
    // AuthenticationRepository.instance .createUserWithEmailAndPassword(email, password);
  }

  Future<bool> createUser(User user) async {
    bool result = await ApiService.registerUser(
      user.fullName,
      user.bloodType,
      user.email,
      user.phoneNo,
      user.password!,
    );
    isAsyncCallProcess.value = false;
    return result;
  }

  // RxBool obsecure() {
  //   hidePassword.value = !hidePassword.value;
  //   return hidePassword;
  // }
}
