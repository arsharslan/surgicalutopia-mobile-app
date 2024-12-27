import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surgicalutopia/main.dart';
import 'package:surgicalutopia/widgets/app_bar/app_bar.dart';
import 'package:surgicalutopia/widgets/custom_text_form_field.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: controller.parentKey,
        appBar: AppBar(
          backgroundColor: Get.theme.colorScheme.primary,
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text("Onboarding"),
        ),
        body: Obx(() {
          print(
              "$firebaseURL${Uri.encodeComponent(controller.user.value?.profilePic ?? "")}?alt=media");
          return Center(
            child: controller.isLoading.value
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                      key: controller.formKey,
                      child: CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(flex: 1),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text("Pick the source"),
                                          actions: [
                                            FilledButton(
                                                onPressed: () async {
                                                  final path = (await ImagePicker()
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery))
                                                      ?.path;
                                                  if (path != null) {
                                                    controller.pickedImage
                                                        .value = File(path);
                                                  }
                                                  Get.back();
                                                },
                                                child: Text("Gallery")),
                                            8.horizontalSpace,
                                            FilledButton(
                                                onPressed: () async {
                                                  final path = (await ImagePicker()
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera))
                                                      ?.path;
                                                  if (path != null) {
                                                    controller.pickedImage
                                                        .value = File(path);
                                                  }
                                                  Get.back();
                                                },
                                                child: Text("Camera"))
                                          ],
                                        ),
                                      );
                                    },
                                    child: controller.pickedImage.value != null
                                        ? PhysicalModel(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                            elevation: 4,
                                            child: Container(
                                              height: 128,
                                              width: 128,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  image: controller.pickedImage
                                                              .value ==
                                                          null
                                                      ? null
                                                      : DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: FileImage(
                                                              controller
                                                                  .pickedImage
                                                                  .value!))),
                                              child: controller
                                                          .pickedImage.value ==
                                                      null
                                                  ? Icon(
                                                      Icons
                                                          .account_circle_rounded,
                                                      size: 128,
                                                      color:
                                                          Colors.grey.shade400)
                                                  : null,
                                            ),
                                          )
                                        : CachedNetworkImage(
                                            height: 128,
                                            width: 128,
                                            imageUrl:
                                                "$firebaseURL${Uri.encodeComponent(controller.user.value?.profilePic ?? "")}?alt=media",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    PhysicalModel(
                                              color: Colors.grey,
                                              shape: BoxShape.circle,
                                              elevation: 4,
                                              child: Container(
                                                height: 128,
                                                width: 128,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: imageProvider)),
                                              ),
                                            ),
                                          ),
                                  ),
                                  64.verticalSpace,
                                  CustomTextFormField(
                                      controller: controller.firstName,
                                      hintText: "First Name",
                                      validator: (value) {
                                        if (value?.isNotEmpty != true) {
                                          return "Please enter first name";
                                        }
                                        return null;
                                      }),
                                  16.verticalSpace,
                                  CustomTextFormField(
                                      controller: controller.lastName,
                                      hintText: "Last Name"),
                                  24.verticalSpace,
                                  Row(
                                    children: [
                                      Expanded(
                                          child: FilledButton(
                                              onPressed:
                                                  controller.isSubmitting.value
                                                      ? null
                                                      : controller.submit,
                                              child: controller
                                                      .isSubmitting.value
                                                  ? SizedBox(
                                                      height: 16,
                                                      width: 16,
                                                      child:
                                                          CircularProgressIndicator())
                                                  : Text("Submit"))),
                                    ],
                                  ),
                                  const Spacer(flex: 2),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
          );
        }));
  }
}
