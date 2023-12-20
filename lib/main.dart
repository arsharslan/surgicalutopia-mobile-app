import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surgicalutopia/widgets/unfocus_gesture/unfocus_gesture.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) {
        return UnFocusGesture(
          child: GetMaterialApp(
            title: "Application",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            theme: ThemeData(
                    scaffoldBackgroundColor:
                        const Color.fromRGBO(251, 246, 255, 1),
                    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme))
                .copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: Color(0xFF61D7B5),
                        tertiary: const Color(0xFFFE9738),
                        background: const Color.fromRGBO(251, 246, 255, 1))),
          ),
        );
      }));
}
