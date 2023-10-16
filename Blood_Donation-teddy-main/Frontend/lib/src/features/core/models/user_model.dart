import 'package:flutter_application_1/src/config/config.dart';
import 'package:flutter_application_1/src/features/core/models/token.model.dart';

class User {
  String fullName;
  String email;
  String? password;
  String bloodType;
  String phoneNo;
  String? dateOfBirth;
  String? medicalCondition;
  String? profilePicture;
  List<TokenValue>? tokensValue;
  String? userId;

  User({
    required this.fullName,
    required this.email,
    this.password,
    required this.bloodType,
    required this.phoneNo,
    this.dateOfBirth,
    this.medicalCondition,
    this.profilePicture,
    this.tokensValue,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      bloodType: json['bloodType'],
      phoneNo: json['phoneNo'],
      dateOfBirth: json['dateOfBirth'],
      medicalCondition: json['medicalCondition'],
      profilePicture: json['profilePicture'],
      tokensValue: (json['tokensValue'] as List<dynamic>?)
          ?.map((tokenValue) => TokenValue.fromJson(tokenValue))
          .toList(),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'bloodType': bloodType,
      'phoneNo': phoneNo,
      'dateOfBirth': dateOfBirth,
      'medicalCondition': medicalCondition,
      'profilePicture': profilePicture,
      'tokensValue':
          tokensValue?.map((tokenValue) => tokenValue.toJson()).toList(),
      'userId': userId,
    };
  }
}

extension UserModelExt on User {
  String get fullImagePath =>
      profilePicture != null ? Config.imageURL + profilePicture! : '';
}
