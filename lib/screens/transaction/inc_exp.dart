import 'package:every_rupee/widgets/expense_listview.dart';
import 'package:every_rupee/widgets/income_listview.dart';
import 'package:flutter/material.dart';

class IncomeExpenseAddTransaction extends StatefulWidget {
  const IncomeExpenseAddTransaction({Key? key}) : super(key: key);

  @override
  State<IncomeExpenseAddTransaction> createState() =>
      _IncomeExpenseAddTransactionState();
}

class _IncomeExpenseAddTransactionState
    extends State<IncomeExpenseAddTransaction>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Container(
                height: MediaQuery.of(context).size.height * .95,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 209, 209, 213),
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: const Color(0xff51425f),
                          ),
                          labelStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 6),
                          labelColor: Colors.white,
                          unselectedLabelColor: const Color(0xff51425f),
                          tabs: const [
                            Tab(
                              text: 'Income',
                            ),
                            Tab(
                              text: 'Expense',
                            ),
                          ]),
                      Expanded(
                          child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        controller: _tabController,
                        children: const [IncomeListview(), ExpenseListview()],
                      ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
