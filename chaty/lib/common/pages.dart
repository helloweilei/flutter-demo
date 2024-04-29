import 'package:chaty/common/routes.dart';
import 'package:chaty/pages/frame/welcome/index.dart';
import 'package:get/route_manager.dart';

class AppPages {
  static const INITIAL = AppRoutes.initial;

  static final routes = [
    GetPage(
        name: 'welcome',
        binding: WelcomeBinding(),
        page: () => const WelcomeView())
  ];
}
