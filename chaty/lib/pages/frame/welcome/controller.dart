import 'package:chaty/pages/frame/welcome/state.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  WelcomeController();
  final title = 'Chaty .';
  final state = WelcomeState();

  @override
  void onReady() {
    super.onReady();
    print("Welcome controller is ready.");
  }
}
