import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:surgicalutopia/app/routes/app_pages.dart';
import 'package:surgicalutopia/main.dart';
import 'package:surgicalutopia/utils/shared_preferences.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.colorScheme.primary,
          elevation: 0,
          foregroundColor: Colors.white,
          title: const Text("Profile"),
        ),
        body: Obx(() {
          return Center(
            child: controller.isLoading.value
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      16.verticalSpace,
                      CachedNetworkImage(
                        height: 128,
                        width: 128,
                        imageUrl:
                            "$firebaseURL${Uri.encodeComponent(controller.user.value?.profilePic ?? "")}?alt=media",
                        imageBuilder: (context, imageProvider) => PhysicalModel(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          elevation: 4,
                          child: Container(
                            height: 128,
                            width: 128,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover, image: imageProvider)),
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.ONBOARDING);
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Profile",
                                            style: Get.textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        const Icon(Icons.arrow_right_sharp)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            8.verticalSpace,
                            InkWell(
                              onTap: () async {
                                await FirebaseAuth.instance.signOut();
                                PreferencesHelper.instance.clearAll();
                                Get.toNamed(Routes.EMAIL_LOGIN);
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Sign Out",
                                            style: Get.textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        const Icon(Icons.arrow_right_sharp)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        }));
  }
}
