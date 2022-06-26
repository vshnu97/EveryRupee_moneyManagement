import 'package:every_rupee/db/transactions/transaction_db.dart';
import 'package:every_rupee/model/category/category_model.dart';
import 'package:every_rupee/model/transactions/transaction_model.dart';
import 'package:every_rupee/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListViewTransactions extends StatefulWidget {
  const ListViewTransactions({Key? key}) : super(key: key);

  @override
  State<ListViewTransactions> createState() => _ListViewTransactionsState();
}

class _ListViewTransactionsState extends State<ListViewTransactions> {
  String title = 'Delete';
  String subtitle = 'Are you sure ?';
  String lottie = 'assets/JSON/delete.json';

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder:
            (BuildContext context, List<TransactionModel> newList, Widget? _) {
          return TransactionDB.instance.transactionListNotifier.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final _value = newList[index];
                      return Slidable(
                        endActionPane:
                            ActionPane(motion: const BehindMotion(), children: [
                          SlidableAction(
                            backgroundColor:
                                const Color.fromARGB(255, 209, 209, 213),
                            onPressed: (index) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditScreen(value: _value)));
                            },
                            label: 'Edit',
                            icon: Icons.edit,
                            foregroundColor: const Color(0xff2e1437),
                          ),
                          SlidableAction(
                              backgroundColor:
                                  const Color.fromARGB(255, 209, 209, 213),
                              onPressed: (index) {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        dialogShow(context, _value.id));
                              },
                              label: 'Delete',
                              icon: Icons.delete,
                              foregroundColor:
                                  const Color.fromARGB(255, 211, 45, 33)),
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            elevation: 7,
                            color: const Color.fromARGB(255, 194, 191, 196),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(37),
                                  bottomLeft: Radius.circular(37)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 38,
                                  backgroundColor:
                                      const Color.fromARGB(192, 41, 24, 48),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      parseDate(_value.date),
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 21),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _value.purpose,
                                        textScaleFactor: 1,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: .5,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      FittedBox(
                                        child: Text(
                                          _value.category.name.toUpperCase(),
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              letterSpacing: 1.5,
                                              color: _value.type ==
                                                      CategoryType.income
                                                  ? const Color.fromARGB(
                                                      255, 16, 163, 24)
                                                  : const Color.fromARGB(
                                                      215, 199, 27, 27)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FittedBox(
                                    child: Text(
                                      '₹ ${_value.amount}',
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,fontSize: 17,
                                          color:
                                              _value.type == CategoryType.income
                                                  ? const Color.fromARGB(
                                                      255, 16, 163, 24)
                                                  : Colors.red[900]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: newList.length > 5 ? 5 : newList.length,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Lottie.asset('assets/JSON/transatn_lottie.json',
                        height: MediaQuery.of(context).size.height * .3),
                    const Text(
                      'No Transaction added',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                          color: Color.fromARGB(255, 157, 10, 10)),
                    )
                  ],
                );
        });
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitDate = _date.split(' ');
    return '${_splitDate.last}\n${_splitDate.first}';
  }

  Dialog dialogShow(BuildContext context, String index) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, index),
    );
  }

  dialogContent(BuildContext context, String index) {
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
                      onPressed: (() {
                        setState(() {
                          TransactionDB.instance.deleteTransaction(index);
                          Navigator.of(context).pop();
                          TransactionDB.instance.refresh();
                        });
                      }),
                      child: Text(
                        title,
                        style: const TextStyle(
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
              child: Lottie.asset(
                lottie,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
