import 'package:flutter/material.dart';
import 'package:my_app/gradient_container.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: GradientContainer(
        color1: Colors.purple,
        color2: Colors.yellow,
      ),
    ),
  ));
}
