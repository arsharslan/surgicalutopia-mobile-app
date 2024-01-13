import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:surgicalutopia/app/data/models/user_model.dart';
import 'package:surgicalutopia/app/data/providers/user_provider.dart';
import 'package:surgicalutopia/app/routes/app_pages.dart';
import 'package:surgicalutopia/main.dart';
import 'package:surgicalutopia/utils/extensions/extensions.dart';
import 'package:surgicalutopia/utils/shared_preferences.dart';
import 'package:surgicalutopia/utils/wrapper_connect.dart';

class OnboardingController extends GetxController {
  Rxn<File> pickedImage = Rxn<File>();
  RxBool isSubmitting = false.obs;

  FToast fToast = FToast();
  final parentKey = GlobalKey();

  final formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (parentKey.currentContext != null) {
      fToast.init(parentKey.currentContext!);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> submit() async {
    if (formKey.currentState?.validate() != true) {
      return;
    }
    isSubmitting.value = true;
    try {
      String? path;
      if (pickedImage.value != null) {
        path =
            "profile_pics/${DateTime.now().millisecond}_${FirebaseAuth.instance.currentUser?.uid}";
        final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': path},
        );

        final ref = FirebaseStorage.instance.ref().child(path);
        final uploadTask = await ref.putFile(pickedImage.value!, metadata);
      }

      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(firstName.text);

      ApiResource<CustomUser?> customUser = await getIt<UserProvider>()
          .createUser(CustomUser(
              firebaseId: FirebaseAuth.instance.currentUser?.uid,
              profilePic: path,
              firstName: firstName.text.nullIfEmpty(),
              lastName: lastName.text.nullIfEmpty()));
      if (customUser is Success<CustomUser?>) {
        await PreferencesHelper.instance
            .setMongoUserId(customUser.data?.id ?? "");
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
    } finally {
      isSubmitting.value = false;
    }
  }
}
