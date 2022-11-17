import 'package:chat_app_firbase/screens/auth/registration/screen/registration_screen.dart';
import 'package:chat_app_firbase/screens/chating/screen/chat_screen.dart';
import 'package:chat_app_firbase/screens/group_info/screen/group_info_screen.dart';
import 'package:chat_app_firbase/screens/homepage/screen/home_page.dart';
import 'package:chat_app_firbase/screens/profile/screen/profile_screen.dart';
import 'package:chat_app_firbase/screens/search_page/screen/search_screen.dart';
import 'package:chat_app_firbase/screens/splash/screen/splash_screen.dart';
import 'package:get/get.dart';

import '../screens/auth/login/screen/log_in_screen.dart';
import 'app_bindings.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name: HomePage.routeName,
      page: () => const HomePage(),
      binding: HomePageBindings(),
    ),
    GetPage(
      name: LogInPage.routeName,
      page: () => const LogInPage(),
      binding: LogInPageBindings(),
    ),
    GetPage(
      name: RegistrationScreen.routeName,
      page: () => const RegistrationScreen(),
      binding: RegistrationPageBindings(),
    ),
    GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
      binding: SplashScreenBindings(),
    ),
    GetPage(
      name: SearchScreen.routeName,
      page: () => const SearchScreen(),
      binding: SearchScreenPageBindings(),
    ),
    GetPage(
      name: ProfileScreen.routeName,
      page: () => const ProfileScreen(),
      binding: ProfilePageBindings(),
    ),
    GetPage(
      name: ChatScreen.routeName,
      page: () => const ChatScreen(),
      binding: ChatScreenBindings(),
    ),
    GetPage(
      name: GroupInfoScreen.routeName,
      page: () => const GroupInfoScreen(),
      binding: GroupInfoPageBindings(),
    ),
  ];
}
