import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:surgicalutopia/app/routes/app_pages.dart';
import 'package:surgicalutopia/main.dart';

class WrapperConnect extends GetConnect {
  signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.EMAIL_LOGIN);
  }

  @override
  Future<Response<T>> get<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      bool softRefresh = false}) async {
    var response = await super.get<T>(
      url,
      headers: headers ?? {"Authorization": "Bearer ${await token}"},
      contentType: contentType,
      query: query,
      decoder: decoder,
    );
    if (response.statusCode == 401) {
      response = await super.get<T>(
        url,
        headers: headers ?? {"Authorization": "Bearer ${await freshToken}"},
        contentType: contentType,
        query: query,
        decoder: decoder,
      );

      if (response.statusCode == 401) {
        signOut();
      }
    }

    return response;
  }

  @override
  Future<Response<T>> post<T>(
    String? url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    var response = await super.post<T>(
      url,
      body,
      headers: headers ?? {"Authorization": "Bearer ${await token}"},
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
    if (response.statusCode == 401) {
      response = await super.post<T>(
        url,
        body,
        headers: headers ?? {"Authorization": "Bearer ${await freshToken}"},
        contentType: contentType,
        query: query,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );
      if (response.statusCode == 401) {
        signOut();
      }
    }
    return response;
  }

  Future<Map<String, dynamic>> httpPatch<T>(
    String? url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    var response = await http.patch(Uri.parse("$baseURL$url"),
        body: body, // is Map ? jsonEncode(body) : body,
        headers: headers ??
            {
              "Content-Type": "multipart/form-data",
              "Authorization": "Bearer ${await token}"
            });
    if (response.statusCode == 401) {
      response = await http.patch(Uri.parse("$baseURL/$url"),
          body: jsonEncode(body),
          headers: headers ??
              {
                "Content-Type": "multipart/form-data",
                "Authorization": "Bearer ${await freshToken}"
              });

      if (response.statusCode == 401) {
        signOut();
      }
    }
    return jsonDecode(response.body);
  }

  @override
  Future<Response<T>> delete<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) async {
    var response = await super.delete(
      url,
      headers: headers ?? {"Authorization": "Bearer ${await token}"},
      contentType: contentType,
      query: query,
      decoder: decoder,
    );

    if (response.statusCode == 401) {
      response = await super.delete(
        url,
        headers: headers ?? {"Authorization": "Bearer ${await freshToken}"},
        contentType: contentType,
        query: query,
        decoder: decoder,
      );
      if (response.statusCode == 401) {
        signOut();
      }
    }
    return response;
  }

  Future<String?>? get token => FirebaseAuth.instance.currentUser?.getIdToken();
  Future<String?>? get freshToken =>
      FirebaseAuth.instance.currentUser?.getIdToken(true);
}
