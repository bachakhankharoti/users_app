import 'dart:async';
import 'package:flutter/material.dart';
import 'package:users_app/authentication/login.dart';

import '../assistants/assistant_methods.dart';
import '../global/global.dart';
import '../mainScreens/main_screen.dart';

class MySlashScreen extends StatefulWidget {
  @override
  State<MySlashScreen> createState() => _MySlashScreenState();
}

class _MySlashScreenState extends State<MySlashScreen> {
  startTimer() {
    fAuth.currentUser != null
        ? AssistantMethods.readCurrentOnlineUserInfo()
        : null;

    Timer(const Duration(seconds: 3), () async {
      if (fAuth.currentUser != null) {
        var currentfirebaseuser = fAuth.currentUser;
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MainScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/2.png"),
          ],
        ),
      ),
    );
  }
}
