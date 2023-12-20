import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(stops: const [
                      0,
                      1,
                      1
                    ], colors: [
                      const Color.fromRGBO(167, 254, 165, 0.60),
                      Get.theme.colorScheme.primary,
                      const Color(0xFF00FF19)
                    ]),
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(48))),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(stops: const [
                      0,
                      1,
                      1
                    ], colors: [
                      const Color.fromRGBO(167, 254, 165, 0.60),
                      Get.theme.colorScheme.primary,
                      const Color(0xFF00FF19)
                    ]),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Get.theme.scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(48))),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(29, 110, 51, 0.098)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(48)),
                          color: Get.theme.scaffoldBackgroundColor),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        Positioned(
          top: 0,
          bottom: 48,
          left: -Get.width * 0.4,
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(Get.width)),
                color: const Color.fromRGBO(52, 168, 83, 0.10)),
          ),
        )
      ],
    );
  }
}
