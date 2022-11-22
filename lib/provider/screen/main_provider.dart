import 'package:chat_app_firbase/provider/provider/home_provider.dart';
import 'package:chat_app_firbase/provider/provider/log_in_provider.dart';
import 'package:chat_app_firbase/provider/provider/registration_provider.dart';
import 'package:chat_app_firbase/provider/screen/home_screen.dart';
import 'package:chat_app_firbase/provider/screen/log_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../app_configs/app_constant.dart';

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

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LogInProvider()),
      ChangeNotifierProvider(create: (_) => RegistrationProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LogInProvider>(context, listen: false);
    provider.getPref();
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return Consumer<LogInProvider>(builder: (context, provider, child) {
          return MaterialApp(
            theme: FlexThemeData.light(scheme: FlexScheme.bahamaBlue),
            debugShowCheckedModeBanner: false,
            home: provider.getEmail == null
                ? const LoginScreen()
                : const HomeScreen(),
          );
        });
      },
    );
  }
}
