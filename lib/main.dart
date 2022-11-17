import 'package:chat_app_firbase/screens/splash/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_configs/app_constant.dart';
import 'app_configs/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: DynamicAppConstant.apiKey,
            appId: DynamicAppConstant.appId,
            messagingSenderId: DynamicAppConstant.messagingSenderId,
            projectId: DynamicAppConstant.projectId));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          theme: FlexThemeData.light(scheme: FlexScheme.bahamaBlue),
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          getPages: AppPages.pages,
        );
      },
    );
  }
}
