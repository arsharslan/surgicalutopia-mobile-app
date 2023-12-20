import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:surgicalutopia/app/routes/app_pages.dart';

class UnFocusGesture extends StatefulWidget {
  const UnFocusGesture({required this.child});

  final Widget child;

  @override
  _UnFocusGestureState createState() => _UnFocusGestureState();
}


class _UnFocusGestureState extends State<UnFocusGesture> {
  late FocusNode node;

  @override
  void initState() {

    node = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          if (!node.hasFocus) FocusScope.of(context).requestFocus(node);
        },
        onLongPress: () async {
          showDialog(
              context: Get.context!,
              builder: (context) {
                return AlertDialog(
                  title: Text("Would you like to sign out"),
                  actions: [
                    OutlinedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Get.offAllNamed(Routes.PHONE_NUMBER);
                        },
                        child: Text("Yes")),
                    8.horizontalSpace,
                    OutlinedButton(onPressed: Get.back, child: Text("No")),
                    8.horizontalSpace,
                  ],
                );
              });
        },
        child: widget.child,
      );
}
