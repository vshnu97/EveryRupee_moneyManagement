// ignore_for_file: deprecated_member_use, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:every_rupee/class/notification_awsme.dart';

import 'package:every_rupee/db/transactions/transaction_db.dart';
import 'package:every_rupee/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

ValueNotifier<bool>notificationListener = ValueNotifier(false);

class _SettingsScreenState extends State<SettingsScreen> {
  String title = 'Clear all Data ';

  String subtitle = 'Are you sure ?';

  String lottie = 'assets/JSON/reset.json';

  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor:Colors.black, systemNavigationBarColor: Colors.black));
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
                fontSize: 22, letterSpacing: 5, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
            child: SizedBox(
              child: Column(
                children: [
                  Card(
                      elevation: 7,
                      color: const Color.fromARGB(255, 194, 191, 196),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(37),
                              bottomLeft: Radius.circular(37))),
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            const Icon(
                              Icons.notifications_outlined,
                              size: 25,
                              color: Color(0xff51425f),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () async {},
                                      child: const Text('Notification',
                                          style: TextStyle(
                                              color: Color(0xff51425f),
                                              fontSize: 18,
                                              letterSpacing: 1))),
                                              ValueListenableBuilder(
                                                valueListenable: notificationListener,
                                                builder: (BuildContext context, bool value, Widget?_)
                                                {
                                                  return  Switch(
                                                  value: value, 
                                                  onChanged:(newValue){notificationAdd(newValue);}
                                                  );
                                                },
                                               
                                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      Share.share(
                          'Hey! check out this new app https://play.google.com/store/apps/details?id=com.fouty.everyrupee');
                    },
                    child: Card(
                        elevation: 7,
                        color: const Color.fromARGB(255, 194, 191, 196),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(37),
                                bottomLeft: Radius.circular(37))),
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              const Icon(
                                Icons.share,
                                size: 25,
                                color: Color(0xff51425f),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                  onPressed: () async {
                                    Share.share(
                                        'Hey! check out this new app https://play.google.com/store/apps/details?id=com.fouty.every_rupee');
                                  },
                                  child: const Text('Share this app',
                                      style: TextStyle(
                                          color: Color(0xff51425f),
                                          fontSize: 18,
                                          letterSpacing: 1)))
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: _launchUrl,
                    child: Card(
                        elevation: 7,
                        color: const Color.fromARGB(255, 194, 191, 196),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(37),
                                bottomLeft: Radius.circular(37))),
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              const Icon(
                                Icons.contact_page,
                                size: 25,
                                color: Color(0xff51425f),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                  onPressed: () {
                                    _launchUrl();
                                  },
                                  child: const Text('Contact us',
                                      style: TextStyle(
                                          color: Color(0xff51425f),
                                          fontSize: 18,
                                          letterSpacing: 1))),
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => dialogShow(context));
                    },
                    child: Card(
                        elevation: 7,
                        color: const Color.fromARGB(255, 194, 191, 196),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(37),
                                bottomLeft: Radius.circular(37))),
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              const Icon(
                                Icons.restart_alt,
                                size: 25,
                                color: Color(0xff51425f),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            dialogShow(context));
                                  },
                                  child: const Text('Reset app',
                                      style: TextStyle(
                                          color: Color(0xff51425f),
                                          fontSize: 18,
                                          letterSpacing: 1)))
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {showDialog(
                                        context: context,
                                        builder: (context) =>
                                            aboutShow(context));},
                    child: Card(
                        elevation: 7,
                        color: const Color.fromARGB(255, 194, 191, 196),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(37),
                                bottomLeft: Radius.circular(37))),
                        child: SizedBox(
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                const Icon(
                                  Icons.info_outline,
                                  size: 25,
                                  color: Color(0xff51425f),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              aboutShow(context));
                                    },
                                    child: const Text('About',
                                        style: TextStyle(
                                            color: Color(0xff51425f),
                                            fontSize: 18,
                                            letterSpacing: 1)))
                              ],
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Dialog dialogShow(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(
        context,
      ),
    );
  }

  dialogContent(
    BuildContext context,
  ) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 80,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 80,
                    child: TextButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'redhat'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: TextButton(
                      onPressed: (() async {
                        await TransactionDB.instance.resetTransactrion();
                        Navigator.of(context).pop();

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen()),
                            (route) => false);
                      }),
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'redhat'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 45,
              child: Lottie.asset(lottie, height: 50),
            ),
          ],
        ),
      ],
    );
  }

  Dialog aboutShow(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 80,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 100,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'EveryRupee',
                    style: TextStyle(
                        fontSize: 21,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff51425f)),
                  ),
                  SizedBox(height: 17),
                  Text(
                    'EveryRupee is a user-friendly,finance management app which allows you to keep track of transactions seamlessly.It helps you to categorize your spending, to create a budget and to stay within the limits sts by you, and also provides you a detailed analysis of your spending habits.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, letterSpacing: 1),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/about_logo.png',
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> _launchUrl() async {
    if (await launch('mailto:vishnuky16@gmail.com')) {
      throw 'Could not launch';
    }
  }
  notificationAdd(valueX) async {
    if (valueX == true) {
      await createPersistentNotification();
    } else {
      await AwesomeNotifications().resetGlobalBadge();
    }
    final shared = await SharedPreferences.getInstance();
    await shared.setBool("notification", valueX);
   notificationListener.value = valueX;
   notificationListener.notifyListeners();
   }
}
