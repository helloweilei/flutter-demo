import 'package:chaty/pages/frame/welcome/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  Widget _buildHeaderTitle(String title) {
    return Text(title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 45));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: _buildHeaderTitle(controller.title)),
    );
  }
}
