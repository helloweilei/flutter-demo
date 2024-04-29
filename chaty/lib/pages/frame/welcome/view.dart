import 'package:chaty/pages/frame/welcome/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  Widget _buildHeaderTitle(String title) {
    return Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
            fontSize: 45.sp));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Container(child: Center(child: _buildHeaderTitle(controller.title))),
    );
  }
}
