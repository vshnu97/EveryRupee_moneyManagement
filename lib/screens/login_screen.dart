import 'package:every_rupee/screens/home.dart';
import 'package:every_rupee/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);

  late SharedPreferences preferences;

  final _username = TextEditingController();

  // ignore: unused_field
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Create your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff51425f)),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    'Create an account and manage your personal finances.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 174, 171, 176)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      maxLength: 12,
                      controller: _username,
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xff51425f),
                          letterSpacing: 2),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle:
                            TextStyle(color: Color.fromARGB(255, 185, 163, 98)),
                        labelText: 'Name *',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 206, 172, 71),
                            letterSpacing: 2),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Username';
                        } else {
                          return null;
                        }
                      },
                      // onChanged: (val) {
                      //   'name' = val;
                      // },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: SizedBox(
                      height: 48,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_username.text.isNotEmpty) {
                            addName(context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(milliseconds: 600),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Color.fromARGB(255, 161, 28, 18),
                              content: Text(
                                'Please enter a name',
                                style: TextStyle(
                                    color: Colors.white, letterSpacing: 2),
                              ),
                            ));
                          }
                        },
                        child: const Text(' Lets Go ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            primary: const Color(0xff51425f)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  Future<void> addName(BuildContext context) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('name', _username.text);
    preferences.setBool('check', true);
    commonUserName = _username.text;

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
