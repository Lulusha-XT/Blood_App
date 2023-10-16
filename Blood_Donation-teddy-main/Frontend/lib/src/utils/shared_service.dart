import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/src/features/authentication/models/login_response_model.dart';

class SharedService {
  static const String KEY_NAME = "login_key";

  static Future<bool> isLoggedIn() async {
    var isCacheKeyExit = await APICacheManager().isAPICacheKeyExist(KEY_NAME);
    return isCacheKeyExit;
  }

  static Future<void> setLoginDetail(LoginResponseModel model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: KEY_NAME,
      syncData: jsonEncode(model.toJson()),
    );

    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<LoginResponseModel?> loginDetails() async {
    var isCacheKeyExists = await APICacheManager().isAPICacheKeyExist(KEY_NAME);

    if (isCacheKeyExists) {
      var cachedData = await APICacheManager().getCacheData(KEY_NAME);

      return loginResponseJson(cachedData.syncData);
    }
    return null;
  }

  static Future<void> logout(BuildContext context) async {
    APICacheManager().deleteCache(KEY_NAME);
    Navigator.of(context).pop();
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }
}
