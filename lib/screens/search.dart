import 'package:every_rupee/db/transactions/transaction_db.dart';
import 'package:every_rupee/model/category/category_model.dart';
import 'package:every_rupee/model/transactions/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchTextContoller = TextEditingController();
  String searchString = "";

  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor:Colors.black, systemNavigationBarColor: Colors.black));
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
                controller: _searchTextContoller,
                onChanged: (value) {
                  setState(() {
                    searchString = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search by Notes name...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)))),
          ),
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable:
                      TransactionDB.instance.transactionListNotifier,
                  builder: (BuildContext context,
                      List<TransactionModel> studentData, Widget? child) {
                    return TransactionDB
                            .instance.transactionListNotifier.value.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              final data = studentData[index];
                              if (data.purpose.toLowerCase().contains(
                                      _searchTextContoller.text
                                          .toLowerCase()) ||
                                  data.category.name.toString().contains(
                                      _searchTextContoller.text
                                          .toLowerCase())) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 8),
                                  child: Card(
                                    elevation: 10,
                                    color: const Color.fromARGB(
                                        255, 194, 191, 196),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(37),
                                            bottomLeft: Radius.circular(37))),
                                    child: SizedBox(
                                        height: 75,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              radius: 38,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      192, 41, 24, 48),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  parseDate(data.date),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 21),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(data.purpose.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: .5,
                                                        color: Colors.white)),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  data.category.name
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                      letterSpacing: 1.5,
                                                      color: data.type ==
                                                              CategoryType
                                                                  .income
                                                          ? const Color
                                                                  .fromARGB(
                                                              255, 16, 163, 24)
                                                          : const Color
                                                                  .fromARGB(215,
                                                              199, 27, 27)),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                '₹ ${data.amount}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    color: data.type ==
                                                            CategoryType.income
                                                        ? const Color.fromARGB(
                                                            255, 16, 163, 24)
                                                        : Colors.red[900]),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                            itemCount: studentData.length,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Lottie.asset('assets/JSON/search_lotttie.json',
                                  height:
                                      MediaQuery.of(context).size.height * .4),
                              const Text(
                                'No transaction to search',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.5,
                                    color: Color.fromARGB(255, 157, 10, 10)),
                              )
                            ],
                          );
                  })),
        ],
      ),
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitDate = _date.split(' ');
    return '${_splitDate.last}\n${_splitDate.first}';
  }
}
