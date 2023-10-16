import 'package:flutter_application_1/src/api/api_services.dart';
import 'package:flutter_application_1/src/features/core/models/user_doner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DonationNotifier extends StateNotifier<List<UserDoner>> {
  DonationNotifier(this._apiService) : super([]);

  final ApiService _apiService;
  bool isNull = false;
  Future<void> getDonatingUsers(String requestId) async {
    final donatingUsers = await _apiService.getDonatingUsers(requestId);
    if (donatingUsers != null) {
      state = donatingUsers;
      isNull = false;
    } else {
      state = [];
      isNull = true;
    }
    print("users: $donatingUsers");
  }

  Future<bool> approvedUserDoners(
      String donationId, String doner, String requestId) async {
    final approvedUser =
        await _apiService.approvedUserDoners(donationId, doner);
    if (approvedUser) {
      final donatingUsers = await _apiService.getDonatingUsers(requestId);
      state = donatingUsers!;
      return true;
    }
    return false;
  }
}
