import 'dart:io';

import 'package:flutter_application_1/src/api/api_services.dart';
import 'package:flutter_application_1/src/features/core/models/user_model.dart';
import 'package:flutter_application_1/src/features/core/controllers/update_profile_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier(this._apiService)
      : super(User(bloodType: '', email: '', fullName: '', phoneNo: ''));
  final ApiService _apiService;
  final controllers = Get.put(UpdateProfileController());
  Future<void> getUser() async {
    final user = await _apiService.getUsersData();

    state = user!;
    print("user $user");
  }

  Future<bool> updateUserInfo(User user, File imageFile) async {
    final updatedUser = await _apiService.updateProfile(user, imageFile);
    if (updatedUser) {
      final user = await _apiService.getUsersData();

      state = user!;
      controllers.isAsyncCallProcess = false.obs;
      return true;
    }
    return false;
  }

  // Future<void> reset() async {
  //   Future.delayed(const Duration(microseconds: 1500), () {
  //     state = UserModel(
  //       bloodType: '',
  //       email: '',
  //       fullName: '',
  //       phoneNo: '',
  //     );
  //   });
  // }
}
