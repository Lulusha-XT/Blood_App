import 'dart:convert';
import 'dart:io';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/src/config/config.dart';
import 'package:flutter_application_1/src/features/authentication/models/login_response_model.dart';
import 'package:flutter_application_1/src/features/core/models/accesToken_model.dart';
import 'package:flutter_application_1/src/features/core/models/sponser.dart';
import 'package:flutter_application_1/src/features/core/models/token.model.dart';
import 'package:flutter_application_1/src/features/core/models/user_model.dart';
import 'package:flutter_application_1/src/features/core/models/blood_request_model.dart';
import 'package:flutter_application_1/src/features/core/models/user_doner.dart';
import 'package:flutter_application_1/src/utils/shared_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final apiService = Provider((ref) => ApiService());

final buttonTappedProvider = StateProvider<bool>((ref) => false);

class ApiService {
  static var client = http.Client();

  static Future<bool> registerUser(String fullName, String bloodType,
      String email, String phoneNo, String password) async {
    Map<String, String> requestHeader = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.registerApi);
    var respons = await client.post(url,
        headers: requestHeader,
        body: jsonEncode({
          "fullName": fullName,
          "email": email,
          "password": password,
          "phoneNo": phoneNo,
          "bloodType": bloodType,
        }));

    if (respons.statusCode == 200) {
      await SharedService.setLoginDetail(loginResponseJson(respons.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> loginUser(String email, String password) async {
    Map<String, String> requestHeader = {'Content-Type': 'application/json'};

    var url = Uri.http(
      Config.apiURL,
      Config.loginApi,
    );
    var respons = await client.post(
      url,
      headers: requestHeader,
      body: jsonEncode({"email": email, "password": password}),
    );

    if (respons.statusCode == 200) {
      await SharedService.setLoginDetail(loginResponseJson(respons.body));
      return true;
    } else {
      return false;
    }
  }

  Future<User?> getUsersData() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}',
    };

    var url = Uri.http(
      Config.apiURL,
      "${Config.getUserById}${loginDetails.data.userId.toString()}",
    );

    var response = await client.get(url, headers: requestHeader);

    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);

      User user = User.fromJson(data["data"]);

      return user;
    } else {
      return null;
    }
  }

  Future<bool> approvedUserDoners(String donationId, String doner) async {
    var lodingDetail = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${lodingDetail?.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.approvedDonation);
    print(url);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "donationId": donationId,
        "doner": doner,
      }),
    );

    if (response.statusCode == 200) {
      print("true");
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
      return false;
    } else {
      print(response.body);
      return false;
    }
  }

  Future<List<BloodRequest>?> getBloodRequest() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}',
    };
    print("hi");
    var url = Uri.http(
      Config.apiURL,
      Config.bloodRequest,
    );
    print(url);

    var response = await client.get(url, headers: requestHeader);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      print("Data: $data");

      if (data["data"] != null) {
        return bloodRequestFromJson(data["data"]);
      }
    }
    return null;
  }

  Future<List<BloodRequest>?> getMyRequest() async {
    var loginDatails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDatails!.data.token.toString()}',
    };

    var url = Uri.http(Config.apiURL,
        "${Config.getBloodRequest}${loginDatails.data.userId.toString()}");
    print(url);
    var response = await client.get(url, headers: requestHeader);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Data: $data");
      if (data != null) {
        return bloodRequestFromJson(data["data"]);
      }
    }
    return null;
  }

  Future<bool> createBloodeRequest(BloodRequest bloodRequest) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}',
    };
    var url = Uri.http(Config.apiURL, Config.getBloodRequest);
    var response = await client.post(url,
        headers: requestHeader, body: jsonEncode(bloodRequest.toJson()));

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
      return false;
    } else {
      return false;
    }
  }

  Future<bool> updateBloodRequest(BloodRequest user) async {
    var lodingDetail = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${lodingDetail?.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.updateUserById);
    var response = await client.put(
      url,
      headers: requestHeaders,
      //  body: jsonEncode(bloodR),
    );
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
      return false;
    } else {
      return false;
    }
  }

  Future<bool> donateNow(String bloodRequestId) async {
    var lodingDetail = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${lodingDetail?.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.donation);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "request": bloodRequestId,
        "donor": lodingDetail?.data.userId,
      }),
    );

    if (response.statusCode == 200) {
      print("true");
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
      return false;
    } else if (response.statusCode == 500) {
      return false;
    } else {
      return false;
    }
  }

  Future<List<BloodRequest>?> getMyDonation() async {
    var loginDatails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDatails!.data.token.toString()}',
    };

    var url = Uri.http(Config.apiURL, Config.getMyDonation);
    print(url);
    var response = await client.get(url, headers: requestHeader);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Data: $data");
      if (data != null) {
        return bloodRequestFromJson(data["data"]);
      }
    }
    return null;
  }

  Future<List<UserDoner>?> getDonatingUsers(String requestId) async {
    var loginDatails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDatails!.data.token.toString()}',
    };

    var url = Uri.http(Config.apiURL, "${Config.getDoners}$requestId");

    var response = await client.get(url, headers: requestHeader);
    print(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Data: $data");
      if (data != null) {
        print(data["data"]);
        return userDonerFromJson(data["data"]);
      }
    }
    return null;
  }

  Future<bool> updateProfile(User user, File imageFile) async {
    try {
      var loginDetails = await SharedService.loginDetails();
      var token = loginDetails?.data.token.toString();

      var request = http.MultipartRequest(
        'PUT',
        Uri.http(Config.apiURL, Config.updateUserById),
      );

      // Set request headers
      request.headers['Authorization'] = 'Basic $token';
      // Set request fields
      request.fields['fullName'] = user.fullName;
      request.fields['email'] = user.email;
      request.fields['phoneNo'] = user.phoneNo;
      request.fields['bloodType'] = user.bloodType;

      // Set profile picture
      var profilePicField = await http.MultipartFile.fromPath(
        'profilePicture',
        imageFile.path,
      );
      request.files.add(profilePicField);

      var streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        return true;
      } else if (streamedResponse.statusCode == 401) {
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil("/login", (route) => false);
        return false;
      } else {
        return false;
      }
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }

  Future<List<Sponser>?> getSponser() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}',
    };

    var url = Uri.http(Config.apiURL, Config.getSponser);
    var response = await client.get(url, headers: requestHeader);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data["data"] != null) {
        return sponserFromJson(data["data"]);
      }
    }
    return null;
  }

  Future<bool> createSponser(Sponser sponser) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}',
    };

    var url = Uri.http(Config.apiURL, Config.createSponser);

    var response = await client.post(url,
        headers: requestHeader, body: jsonEncode(sponser.toJson()));

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
      return false;
    } else {
      return false;
    }
  }

  Future<List<TokenValue>?> getTokenValue() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}',
    };

    var url = Uri.http(Config.apiURL, Config.getTokenValue);
    var response = await client.get(url, headers: requestHeader);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data["data"] != null) {
        return tokenValueFromJson(data["data"]);
      }
    }
    return null;
  }

  Future<bool> createSponserToken(AccessToken sponserToken) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}',
    };

    var url = Uri.http(Config.apiURL, Config.createSponserToken);

    var response = await client.post(url,
        headers: requestHeader, body: jsonEncode(sponserToken.toJson()));

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
      return false;
    } else {
      return false;
    }
  }

  Future<List<TokenValue>?> getSponserToken() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}',
    };

    var url = Uri.http(Config.apiURL, Config.getTokenValue);
    var response = await client.get(url, headers: requestHeader);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data["data"] != null) {
        return tokenValueFromJson(data["data"]);
      }
    }
    return null;
  }
}
