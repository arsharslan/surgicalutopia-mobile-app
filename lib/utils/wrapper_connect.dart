import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:surgicalutopia/app/routes/app_pages.dart';
import 'package:surgicalutopia/main.dart';
import 'package:surgicalutopia/utils/extensions/extensions.dart';

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

  Future<http.StreamedResponse> _postCore(
      {required String url, required Map<String, dynamic> body}) async {
    var headers = {
      'Content-Type': 'application/json;charset=utf-8',
      'Authorization': 'Bearer ${await token}'
    };
    var request = http.Request('POST', Uri.parse("$baseURL$url"));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<ApiResource<T?>> wpost<T>(
    String? url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    var response = await _postCore(
      url: url ?? "",
      body: body,

      /* contentType: contentType ?? 'application/x-www-form-urlencoded; charset=UTF-8',
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress, */
    );
    if (response.statusCode == 401) {
      response = await _postCore(
        url: url ?? "",
        body: body,

        /* contentType: contentType ?? 'application/x-www-form-urlencoded; charset=UTF-8',
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress, */
      );
      if (response.statusCode == 401) {
        signOut();
      }
    }
    if (response.statusCode < 300) {
      final body = await response.stream.bytesToString();
      return Success<T?>(
          decoder?.call(jsonDecode(body)));
    } else {
      return Error<T?>(body);
    }
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

  Future<String?>? get token async {
    String? firebaseToken =
        await FirebaseAuth.instance.currentUser?.getIdToken();
    print(firebaseToken);
    return firebaseToken;
  }

  Future<String?>? get freshToken =>
      FirebaseAuth.instance.currentUser?.getIdToken(true);
}

abstract class ApiResource<T> extends Equatable {}

class Error<T> extends ApiResource<T> {
  Error(this.msg);

  final String msg;

  String getError() {
    try {
      return ErrorResponse.fromJson(json.decode(msg)).getString();
    } catch (e) {
      return msg;
    }
  }

  @override
  List<Object?> get props => [msg];
}

class Success<T> extends ApiResource<T> {
  Success(this.data);

  final T data;

  @override
  List<Object?> get props => [data];
}

class ErrorResponse {
  String? network;
  String? error;
  dynamic detail;
  List<String>? bankAccount;
  List<String>? firstName;
  List<String>? pan;
  List<String>? gstNumber;
  List<String>? email;
  List<String>? product;
  List<String>? mobile;
  List<String>? nonFieldErrors;
  List<String>? referredCode;
  List<String>? domain;

  ErrorResponse(
      {this.network,
      this.error,
      this.detail,
      this.firstName,
      this.pan,
      this.bankAccount,
      this.gstNumber,
      this.email,
      this.product,
      this.mobile,
      this.nonFieldErrors,
      this.referredCode,
      this.domain});

  String getString() {
    var isList = detail is List<dynamic>;
    return (bankAccount?.let((it) => "${it?.join(",")}\n") ?? "") +
        (gstNumber?.let((it) => "${it?.join(",")}\n") ?? "") +
        (error?.let((it) => "$it\n") ?? "") +
        (isList
            ? ((detail as List<dynamic>).firstOrNull?.toString())
            : (detail is String)
                ? ((detail as String).let((it) => "$it\n") ?? "")
                : "") +
        (email?.let((it) => "$it\n") ?? "") +
        (mobile?.let((it) => "${it?.join(",")}\n") ?? "") +
        (referredCode?.let((it) => "${it?.join(",")}\n") ?? "") +
        (pan?.let((it) => "${it?.join(",")}\n") ?? "") +
        (firstName?.let((it) => "Username - ${it?.join(",")}\n") ?? "") +
        (product?.let((it) => "${it?.join(",")}\n") ?? "") +
        (nonFieldErrors?.let((it) => "${it?.join(",")}\n") ?? "") +
        (domain?.let((it) => "${it?.join(",")}\n") ?? "");
  }

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        detail: (json['detail'] is List<dynamic>?)
            ? json['detail']?.map((e) => e as String).toList()
            : json['detail'] as String?,
        network: json['network'],
        error: json['error'],
        referredCode: json['referred_code'] == null
            ? null
            : List<String>.from(json['referred_code'].map((e) => '$e')),
        nonFieldErrors: json['non_field_errors'] == null
            ? null
            : List<String>.from(json['non_field_errors'].map((e) => '$e')),
        mobile: json['mobile'] == null
            ? null
            : List<String>.from(json['mobile'].map((e) => '$e')),
        product: json['product'] == null
            ? null
            : List<String>.from(json['product'].map((e) => '$e')),
        email: json['email'] == null
            ? null
            : List<String>.from(json['email'].map((e) => '$e')),
        firstName: json['first_name'] == null
            ? null
            : List<String>.from(json['first_name'].map((e) => '$e')),
        pan: json['pan'] == null
            ? null
            : List<String>.from(json['pan'].map((e) => '$e')),
        gstNumber: json['gst_number'] == null
            ? null
            : List<String>.from(json['gst_number'].map((e) => '$e')),
        bankAccount: json['bank_account'] == null
            ? null
            : List<String>.from(json['bank_account'].map((e) => '$e')),
        domain: json['domain'] == null
            ? null
            : List<String>.from(json['domain'].map((e) => '$e')),
      );
}
