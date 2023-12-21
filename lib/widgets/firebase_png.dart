import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:surgicalutopia/main.dart';

class FirebaseImageController extends GetxController
    with GetTickerProviderStateMixin {
  int rotation = 0;
  TransformationController transformationController =
      TransformationController();
}

class FirebasePng extends StatelessWidget {
  final String path;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final bool showPreview;
  final List<Widget> actions;
  final List<Widget> verticalActions;
  final bool? compress;
  // static Reference ref = FirebaseStorage.instance.ref();
  static Map<String, String> urls = {};
  Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;

  final controller = FirebaseImageController();

  FirebasePng(this.path,
      {Key? key,
      this.boxFit = BoxFit.cover,
      this.width,
      this.height,
      this.compress = false,
      this.imageBuilder,
      this.showPreview = false,
      this.actions = const <Widget>[],
      this.verticalActions = const <Widget>[]})
      : super(key: key);

  displayPreview() => showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: Get.back, icon: const Icon(Icons.close)),
            ],
          ),
          content: StatefulBuilder(builder: (context, setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: RotatedBox(
                    quarterTurns: controller.rotation,
                    child: InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(double.infinity),
                        minScale: 0.5,
                        maxScale: 5,
                        transformationController:
                            controller.transformationController,
                        child: FirebasePng(path)),
                  ),
                ),
                8.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            controller.rotation = controller.rotation + 1;
                          });
                        },
                        icon: const Icon(Icons.rotate_right)),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            /*controller.zoomAnimator.animateTo(
                                            controller.zoomAnimator.value - 0.1,
                                            duration: const Duration(
                                                milliseconds: 200));*/
                            var value = controller
                                    .transformationController.value
                                    .entry(0, 0) -
                                0.1;
                            if (value >= 1) {
                              setMatrixValue(value);
                            }
                          },
                          child: const Card(
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.zoom_out_rounded,
                                size: 14,
                              ),
                            ),
                          ),
                        ),
                        4.horizontalSpace,
                        InkWell(
                          onTap: () {
                            /* controller.zoomAnimator.animateTo(1,
                                            duration: const Duration(
                                                milliseconds: 200));*/

                            controller.transformationController.value = Matrix4(
                                1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);
                          },
                          child: const Icon(Icons.fullscreen),
                        ),
                        4.horizontalSpace,
                        InkWell(
                          onTap: () {
                            /*controller.zoomAnimator.animateTo(
                                            controller.zoomAnimator.value + 0.1,
                                            duration: const Duration(
                                                milliseconds: 200));*/

                            var value = controller
                                    .transformationController.value
                                    .entry(0, 0) +
                                0.1;
                            if (value <= 5) {
                              setMatrixValue(value);
                            }
                          },
                          child: const Card(
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.zoom_in_rounded,
                                size: 14,
                              ),
                            ),
                          ),
                        ),
                        4.horizontalSpace,
                        ...actions
                      ],
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: verticalActions),
                ),
                /*   ...verticalActions.map((e) => Align(
                      alignment: Alignment.centerLeft,
                      child: e,
                    )) */
              ],
            );
          })));

  String getFirebaseURL() {
    var encodedPath = Uri.encodeComponent(path);
    String baseUrl = firebaseURL;
    return "$baseUrl/o/$encodedPath?alt=media";
  }

  void setMatrixValue(double value) {
    controller.transformationController.value = Matrix4(
      value,
      // controller.transformationController.value.entry(0, 0),
      controller.transformationController.value.entry(1, 0),
      controller.transformationController.value.entry(2, 0),
      controller.transformationController.value.entry(3, 0),
      controller.transformationController.value.entry(0, 1),
      value,
      // controller.transformationController.value.entry(1, 1),
      controller.transformationController.value.entry(2, 1),
      controller.transformationController.value.entry(3, 1),
      controller.transformationController.value.entry(0, 2),
      controller.transformationController.value.entry(1, 2),
      value,
      // controller.transformationController.value.entry(2, 2),
      controller.transformationController.value.entry(3, 2),
      controller.transformationController.value.entry(0, 3),
      controller.transformationController.value.entry(1, 3),
      controller.transformationController.value.entry(2, 3),
      controller.transformationController.value.entry(3, 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showPreview ? displayPreview : null,
      child: CachedNetworkImage(
        imageUrl: getFirebaseURL(),
        imageBuilder: imageBuilder,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: boxFit,
        height: height,
        width: width,
        memCacheHeight: compress == true ? 500 : null,
        memCacheWidth: compress == true ? 500 : null,
      ),
    );
  }
}
