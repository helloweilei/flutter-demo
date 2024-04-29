import 'package:chaty/pages/frame/welcome/controller.dart';
import 'package:get/get.dart';

class WelcomeBinding implements Bindings {
  WelcomeBinding();

  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
  }
}
