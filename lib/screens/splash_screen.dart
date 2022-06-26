// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'dart:async';
import 'package:every_rupee/screens/home.dart';
import 'package:every_rupee/screens/login_screen.dart';
import 'package:every_rupee/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

String commonUserName = '';

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () => callHome());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/images/splash.png',
            height: 190,
          )),
          const Text('EveryRupee',
              style: TextStyle(
                  fontFamily: 'Schyler',
                  fontSize: 22,
                  color: Color(0xff2e1437),
                  fontWeight: FontWeight.w300,
                  letterSpacing: 3)),
        ],
      ),
    );
  }

  callHome() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getBool('check') ?? false;
    notificationListener.value = pref.getBool('notification') ?? false;
    commonUserName = pref.getString('name') ?? 'User';
    notificationListener.notifyListeners();
    if (data == false) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }
}
