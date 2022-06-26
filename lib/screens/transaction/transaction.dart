// ignore_for_file: unused_local_variable

import 'package:every_rupee/class/reminder.dart';
import 'package:every_rupee/db/transactions/transaction_db.dart';

import 'package:every_rupee/screens/splash_screen.dart';
import 'package:every_rupee/screens/transaction/inc_exp.dart';
import 'package:every_rupee/widgets/listview.dart';
import 'package:every_rupee/widgets/piechart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  TimeOfDay currentTime = TimeOfDay.now();

  // onClickNotifications(String? payload) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => const HomeScreen (),
  //   ));
  //   return null;
  // }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    NotificationApi().init(initScheduled: true);
    // listenNotifications();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
//  void listenNotifications() {
//     NotificationApi.onNotifications.listen(onClickNotifications);
//   }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor:Colors.black, systemNavigationBarColor: Colors.black));
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            ' Welcome',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            " $commonUserName",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xffc74066),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            timePicking(context: context);
                          },
                          icon: const Icon(
                            Icons.notifications,
                            size: 30,
                          ))
                    ],
                  ),
                ),
                const Center(
                  child: Text(
                    'EveryRupee',
                    style: TextStyle(
                        fontSize: 34,
                        fontFamily: 'Trajan',
                        fontWeight: FontWeight.w800,
                        color: Color(0xff480048),
                        letterSpacing: 4.8),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                width: double.infinity,
                height: height * .72,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 209, 209, 213),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .19,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: width * .55,
                            height: height * .08,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 245, 245, 245),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xff51425f),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  ' Amount Left',
                                  textScaleFactor: 1.1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                      fontSize: 17,
                                      color: Color(0xff2e1437)),
                                ),
                                ValueListenableBuilder(
                                    valueListenable:
                                        TransactionDB.instance.totalamount,
                                    builder: (BuildContext context,
                                        dynamic value, Widget? child) {
                                      return FittedBox(
                                        child: Text('₹ $value',
                                            textScaleFactor: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xff2e1437),
                                                fontSize: 22)),
                                      );
                                    }),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: width * .42,
                                height: height * .07,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(121, 74, 214, 14),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(142, 41, 160, 38),
                                      offset: Offset(0.0, 1.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'INCOME ',
                                      textScaleFactor: 1.1,
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable:
                                          TransactionDB.instance.incomeTotal,
                                      builder: (BuildContext context,
                                          double value, Widget? child) {
                                        return FittedBox(
                                          child: Text('₹ $value',
                                              textScaleFactor: 1.1,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: width * .42,
                                height: height * .07,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(121, 193, 17, 17),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(217, 159, 54, 54),
                                      offset: Offset(0.0, 1.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'EXPENSE ',
                                      textScaleFactor: 1.1,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 1.5),
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable:
                                          TransactionDB.instance.expenseTotal,
                                      builder: (BuildContext context,
                                          double value, Widget? child) {
                                        return FittedBox(
                                          child: Text('₹ $value',
                                              textScaleFactor: 1.1,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: const Color.fromARGB(255, 88, 74, 102),
                          ),
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5),
                          labelColor: Colors.white,
                          unselectedLabelColor: const Color(0xff51425f),
                          tabs: [
                            const Tab(
                              text: 'Recent',
                            ),
                            Tab(
                                child: Image.asset(
                              'assets/images/trend.png',
                              height: 35,
                              width: 50,
                            )),
                          ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const IncomeExpenseAddTransaction()));
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff2e1437),
                                  fontSize: 16),
                            ))
                      ],
                    ),
                    Expanded(
                        child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      controller: _tabController,
                      children: const [
                        ListViewTransactions(),
                        Center(child: TransactionChart())
                      ],
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  timePicking({required context}) async {
    final Time sheduledTime;
    final TimeOfDay? pickedTIme = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: currentTime,
    );
    if (pickedTIme != null && pickedTIme != currentTime) {
      setState(() {
        NotificationApi.showScheduledNotifications(
            title: "EveryRuppe",
            body: "Hey $commonUserName.You had forgoten to add something",
            scheduledTime: Time(pickedTIme.hour, pickedTIme.minute, 0));
      });
    }
  }
}
