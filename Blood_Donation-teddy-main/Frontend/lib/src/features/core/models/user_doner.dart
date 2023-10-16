import 'package:flutter_application_1/src/features/core/models/user_model.dart';

List<UserDoner> userDonerFromJson(dynamic str) =>
    List<UserDoner>.from((str).map((x) => UserDoner.fromJson(x)));

class UserDoner {
  final String donationId;
  final User donor;
  final String status;

  UserDoner({
    required this.donationId,
    required this.donor,
    required this.status,
  });

  factory UserDoner.fromJson(Map<String, dynamic> json) {
    return UserDoner(
      donationId: json['donationId'],
      donor: User.fromJson(json['donor']),
      status: json['status'],
    );
  }
}
