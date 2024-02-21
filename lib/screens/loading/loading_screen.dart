import 'package:flutter/material.dart';
import 'package:tetris/theme/colors.dart';

class LoadingScreen extends StatelessWidget {
  LoadingScreen({Key? key}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLogin();
    });
  }

  void _checkLogin() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GPColor.bgPrimary,
      body: Center(child: Image.asset("assets/images/Logo1.png")),
    );
  }
}
