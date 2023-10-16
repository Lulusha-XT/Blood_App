import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(jsonDecode(str));

class LoginResponseModel {
  late final String message;
  late final Data data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    data = Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['message'] = message;
    _data['data'] = data.toJson();

    return _data;
  }
}

class Data {
  late final String fullName;
  late final String email;
  late final String token;
  late final String userId;

  Data(
      {required this.fullName,
      required this.email,
      required this.token,
      required this.userId});

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['fullName'] = fullName;
    _data['email'] = email;
    _data['token'] = token;
    _data['userId'] = userId;

    return _data;
  }

  Data.fromJson(Map<String, dynamic> json) {
    fullName = json["fullName"];
    email = json["email"];
    userId = json["userId"];
    token = json["token"];
  }
}
