// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:every_rupee/db/transactions/transaction_db.dart';
import 'package:every_rupee/model/category/category_model.dart';
import 'package:every_rupee/model/transactions/transaction_model.dart';
import 'package:every_rupee/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:month_year_picker/month_year_picker.dart';

class IncomeListview extends StatefulWidget {
  const IncomeListview({Key? key}) : super(key: key);

  @override
  State<IncomeListview> createState() => _IncomeListviewState();
}

ValueNotifier<bool> visibleMonth = ValueNotifier(false);

class _IncomeListviewState extends State<IncomeListview> {
  String title = 'Delete';
  String subtitle = 'Are you sure ?';
  String lottie = 'assets/JSON/delete.json';
  DateTime selectedMonth = DateTime.now();

  ValueNotifier<List<TransactionModel>> selectedlist =
      TransactionDB.instance.incomeTransactionListNotiFier;

  String? dropdownvalue;

  List<String> items = [
    'Today',
    'Yesterday',
    'Monthly',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                    color: const Color(0xff948e99),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: const Text('Sort',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            color: Color.fromARGB(255, 18, 22, 2),
                          )),
                      value: dropdownvalue,
                      dropdownColor: const Color(0xff948e99),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xffe7eed0),
                          fontSize: 15,
                          letterSpacing: 1),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: dropdownvalue == 'Monthly' ? true : false,
                  child: TextButton(
                      onPressed: () {
                        pickDate();
                      },
                      child: Text(DateFormat('MMMM').format(selectedMonth))))
            ],
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
              valueListenable: valueChecking(context),
              builder: (BuildContext context, List<TransactionModel> newList,
                  Widget? _) {
                return ListView.builder(
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
                            foregroundColor:
                                const Color.fromARGB(255, 130, 94, 27),
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
                        child: Card(
                          elevation: 5,
                          color: const Color.fromARGB(255, 194, 191, 196),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(37),
                                bottomLeft: Radius.circular(37)),
                          ),
                          child: SizedBox(
                            height: 75,
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
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 21),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _value.purpose,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: .5,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      _value.category.name.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          letterSpacing: 1.5,
                                          color:
                                              _value.type == CategoryType.income
                                                  ? const Color.fromARGB(
                                                      255, 16, 163, 24)
                                                  : const Color.fromARGB(
                                                      215, 199, 27, 27)),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    '₹ ${_value.amount}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color:
                                            _value.type == CategoryType.income
                                                ? const Color.fromARGB(
                                                    255, 16, 163, 24)
                                                : Colors.red[900]),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                  },
                  itemCount: newList.length,
                );
              }),
        ),
      ],
    );
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

  ValueNotifier<List<TransactionModel>> valueChecking(context) {
    visibleMonth.value = false;
    if (dropdownvalue == 'Today') {
      TransactionDB.instance.sortTransaction(
          TransactionDB.instance.incomeTransactionListNotiFier.value);
      return TransactionDB.instance.todayListNotifier;
    }
    if (dropdownvalue == 'Yesterday') {
      TransactionDB.instance.sortTransaction(
          TransactionDB.instance.incomeTransactionListNotiFier.value);
      return TransactionDB.instance.yesterdayListNotifier;
    }
    if (dropdownvalue == 'Monthly') {
      visibleMonth.value = true;
      return TransactionDB.instance.monthelyListNotifier;
    }

    return selectedlist;
  }

  pickDate() async {
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: selectedMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    setState(() {
      selectedMonth = selected ?? DateTime.now();
    });
    TransactionDB.instance.monthelyListNotifier.value.clear();
    updateData();
    TransactionDB.instance.monthelyListNotifier.notifyListeners();
  }

  updateData() async {
    Future.forEach(TransactionDB.instance.incomeTransactionListNotiFier.value,
        (TransactionModel model) {
      if (model.date.month == selectedMonth.month &&
          model.date.year == selectedMonth.year) {
        TransactionDB.instance.monthelyListNotifier.value.add(model);
      }
    });
  }
}
