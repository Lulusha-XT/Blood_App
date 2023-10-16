import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodRequestControllers extends GetxController {
  static BloodRequestControllers get instance => Get.find();

  final bloodType = TextEditingController();
  final reason = TextEditingController();
  final unitRequired = TextEditingController();
  final deadLine = TextEditingController();
  final hospital = TextEditingController();
  final personInCharge = TextEditingController();
  final contactNumber = TextEditingController();
  final patientName = TextEditingController();
  final location = TextEditingController();

  RxBool hidePassword = true.obs;
  String defaultValue = 'A+';
  RxBool isAsyncCallProcess = false.obs;

  void resetControllers() {
    bloodType.text = ""; // Set to the initial/default value
    reason.text = ""; // Set to the initial/default value
    unitRequired.text = ""; // Set to the initial/default value
    deadLine.text = ""; // Set to the initial/default value
    hospital.text = ""; // Set to the initial/default value
    personInCharge.text = ""; // Set to the initial/default value
    contactNumber.text = ""; // Set to the initial/default value
    patientName.text = ""; // Set to the initial/default value
    location.text = ""; // Set to the initial/default value
  }

  Rx<DateTime?> selectedDeadline = Rx(null);
}
