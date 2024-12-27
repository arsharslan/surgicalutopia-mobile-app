import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:surgicalutopia/app/data/models/user_model.dart';
import 'package:surgicalutopia/main.dart';
import '../controllers/leaderboard_controller.dart';
import 'dart:math';
import "package:collection/collection.dart";

class LeaderboardView extends GetView<LeaderboardController> {
  const LeaderboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
/*       appBar: AppBar(
            backgroundColor: Get.theme.colorScheme.primary,
            elevation: 0,
            foregroundColor: Colors.white,
            title: const Text("Le"),
          ), */
          body: Column(
        children: [
          SizedBox(
            height: 310,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(stops: const [
                    0,
                    1,
                    1
                  ], colors: [
                    const Color.fromRGBO(167, 254, 165, 0.60),
                    Get.theme.colorScheme.primary,
                    const Color(0xFF00FF19)
                  ])),
                ),
                SizedBox(
                  child: CustomPaint(
                    size: Size(1080, 1080),
                    painter: RadiatingLinesPainter(),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 280,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Transform.scale(
                                scale: 0.8,
                                child: _buildLeaderUi(controller.users[1], 2)),
                          ],
                        ),
                        _buildLeaderUi(controller.users.first, 1),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Transform.scale(
                                scale: 0.8,
                                child: _buildLeaderUi(controller.users[2], 3)),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: Offset(0, -24),
              child: Container(
                decoration: BoxDecoration(
                    color: Get.theme.scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(32))),
                child: ListView(
                    children: controller.users
                        .sublist(3)
                        .mapIndexed((index, user) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Row(
                                children: [
                                  Text((index + 3).toString(),
                                      style: Get.textTheme.titleMedium),
                                  8.horizontalSpace,
                                  CachedNetworkImage(
                                    height: 32,
                                    width: 32,
                                    imageUrl:
                                        "$firebaseURL${Uri.encodeComponent(user.profilePic ?? "")}?alt=media",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: imageProvider)),
                                    ),
                                  ),
                                  16.horizontalSpace,
                                  Text(
                                      "${user.firstName ?? ""} ${user.lastName ?? ""}",
                                      style: Get.textTheme.titleMedium),
                                  const Spacer(),
                                  Image.asset(
                                    "assets/icons/fire.png",
                                    height: 18,
                                    width: 18,
                                  ),
                                  2.horizontalSpace,
                                  Text(user.points?.toString() ?? "",
                                      style: Get.textTheme.titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold))
                                ],
                              ),
                            ))
                        .toList()),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
                "Climb the Leaderboard! Earn Points for Every Right Answer."),
          )
        ],
      ));
    });
  }

  Widget _buildLeaderUi(CustomUser user, int rank) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: rank == 1 ? 176 : 146,
          child: Stack(
            children: [
              Column(
                children: [
                  if (rank == 1) ...[
                    SvgPicture.asset(
                      "assets/icons/crown.svg",
                      width: 48,
                      height: 32,
                    ),
                    2.verticalSpace,
                  ],
                  CachedNetworkImage(
                    height: 128,
                    width: 128,
                    imageUrl:
                        "$firebaseURL${Uri.encodeComponent(user.profilePic ?? "")}?alt=media",
                    imageBuilder: (context, imageProvider) => Container(
                      height: 128,
                      width: 128,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xFFFFDD00), width: 4),
                          image: DecorationImage(
                              fit: BoxFit.cover, image: imageProvider)),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFFFDD00)),
                  child: Center(
                    child: Text(rank.toString(),
                        style: Get.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ],
          ),
        ),
        Text("${user.firstName ?? ""} ${user.lastName ?? ""}",
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Image.asset(
              "assets/icons/fire.png",
              height: 18,
              width: 18,
            ),
            2.horizontalSpace,
            Text(user.points?.toString() ?? "",
                style: Get.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold))
          ],
        )
      ],
    );
  }
}

class RadiatingLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.transparent
      ..strokeWidth = 2.0;

    final Paint fillPaint1 = Paint()..color = Colors.transparent;
    final Paint fillPaint2 = Paint()..color = Colors.grey.withOpacity(0.1);

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width * 2, size.height * 2) / 2;

    const int numLines = 20; // Number of lines
    for (int i = 0; i < numLines; i++) {
      final double startAngle = (2 * pi / numLines) * i;
      final double endAngle = (2 * pi / numLines) * (i + 1);

      // Calculate the points for the two lines
      final Offset startPoint = Offset(
        center.dx + radius * cos(startAngle),
        center.dy + radius * sin(startAngle),
      );
      final Offset endPoint = Offset(
        center.dx + radius * cos(endAngle),
        center.dy + radius * sin(endAngle),
      );

      // Create a triangular path between the two lines
      final Path path = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(startPoint.dx, startPoint.dy)
        ..lineTo(endPoint.dx, endPoint.dy)
        ..close();

      // Fill with alternating colors
      canvas.drawPath(path, i % 2 == 0 ? fillPaint1 : fillPaint2);

      // Draw the lines
      canvas.drawLine(center, startPoint, linePaint);
      canvas.drawLine(center, endPoint, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Set to true if the painter should repaint on updates
  }
}
