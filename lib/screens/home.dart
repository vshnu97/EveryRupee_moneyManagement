import 'package:every_rupee/screens/add_screens/addd.dart';
import 'package:every_rupee/screens/category.dart';
import 'package:every_rupee/screens/search.dart';
import 'package:every_rupee/screens/settings.dart';
import 'package:every_rupee/screens/transaction/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _myPage = PageController(initialPage: 0);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
         systemNavigationBarColor: Colors.black));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .07,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 32.0,
                padding: const EdgeInsets.only(left: 28.0),
                icon: const Icon(Icons.home),
                highlightColor: const Color(0xff51425f),
                color: _selectedIndex == 0
                    ? const Color(0xffc74066)
                    : const Color(0xff2e1437),
                onPressed: () {
                  onTabTapped(0);

                  _myPage.jumpToPage(0);
                },
              ),
              IconButton(
                iconSize: 32.0,
                padding: const EdgeInsets.only(right: 28.0),
                icon: const Icon(Icons.search),
                highlightColor: const Color(0xff51425f),
                color: _selectedIndex == 1
                    ? const Color(0xffc74066)
                    : const Color(0xff2e1437),
                onPressed: () {
                  onTabTapped(1);

                  _myPage.jumpToPage(1);
                },
              ),
              IconButton(
                iconSize: 32.0,
                padding: const EdgeInsets.only(left: 28.0),
                icon: const Icon(Icons.category_outlined),
                highlightColor: const Color(0xff51425f),
                color: _selectedIndex == 2
                    ? const Color(0xffc74066)
                    : const Color(0xff2e1437),
                onPressed: () {
                  onTabTapped(2);

                  _myPage.jumpToPage(2);
                },
              ),
              IconButton(
                iconSize: 32.0,
                padding: const EdgeInsets.only(right: 28.0),
                icon: const Icon(Icons.settings),
                highlightColor: const Color(0xff51425f),
                color: _selectedIndex == 3
                    ? const Color(0xffc74066)
                    : const Color(0xff2e1437),
                onPressed: () {
                  onTabTapped(3);

                  _myPage.jumpToPage(3);
                },
              )
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _myPage,
        // ignore: avoid_types_as_parameter_names
        onPageChanged: (int) {},
        children: const [
          Transactions(),
          SearchScreen(),
          CategoryScreen(),
          SettingsScreen(),
        ],
        physics: const NeverScrollableScrollPhysics(),
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: SizedBox(
          height: 67.0,
          width: 67.0,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: const Color(0xff51425f),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AdTransaction()));
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
