import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:surgicalutopia/app/data/models/user_model.dart';
import 'package:surgicalutopia/main.dart';
import 'package:surgicalutopia/utils/shared_preferences.dart';
import 'package:surgicalutopia/utils/wrapper_connect.dart';

class UserProvider extends WrapperConnect {
  UserProvider() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return CustomUser.fromJson(map);
      if (map is List)
        return map.map((item) => CustomUser.fromJson(item)).toList();
    };
    httpClient.baseUrl = baseURL;
    httpClient.timeout = const Duration(seconds: 20);
  }

  Future<Response<CustomUser?>> findUser() async {
    final response = await get<CustomUser?>("user/",
        query: {"firebaseId": FirebaseAuth.instance.currentUser?.uid},
        decoder: (data) =>
            CustomUser.fromJson(data is List ? data.first : data));
    return response;
  }

  Future<CustomUser?> getUser() async {
    final response = await get<CustomUser?>(
        "user/${PreferencesHelper.instance.mongoUserID}",
        decoder: (data) => CustomUser.fromJson(data));
    return response.body;
  }

  Future<ApiResource<CustomUser?>> createUser(CustomUser customUser) async {
    final response = await wpost("user/", customUser.toJson(),
        decoder: (data) => CustomUser.fromJson(data));
    return response;
  }

  Future<ApiResource<CustomUser?>> updateUser(CustomUser customUser) async {
    final response = await wput("user/${customUser.id}/", customUser.toJson(),
        decoder: (data) => CustomUser.fromJson(data));
    return response;
  }

  Future<List<CustomUser>?> getLeaderboard() async {
    final response = await get<List<CustomUser>?>(
        "leaderboard",
        decoder: (data) =>
            List<CustomUser>.from(data.map((e) => CustomUser.fromJson(e))));
    return response.body;
  }
}
