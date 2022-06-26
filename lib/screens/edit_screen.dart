import 'package:every_rupee/db/category/category_db.dart';
import 'package:every_rupee/db/transactions/transaction_db.dart';
import 'package:every_rupee/model/category/category_model.dart';
import 'package:every_rupee/model/transactions/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditScreen extends StatefulWidget {
  final TransactionModel value;

  const EditScreen({Key? key, required this.value}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryMOdel;
  String? _categoryID;

  final _amountController = TextEditingController();
  final _purposeController = TextEditingController();

  @override
  void initState() {
    _purposeController.text = widget.value.purpose;
    _amountController.text = widget.value.amount.toString();
    _selectedCategorytype = widget.value.category.type;
    _selectedCategoryMOdel = widget.value.category;
    _selectedDate = widget.value.date;
    //  _amountController = widget.value.amount.toString() as TextEditingController;
//_purposeController = widget.value.purpose.toString() as TextEditingController;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          Center(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/editing.png',
                  height: 180,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 178,
                  ),
                  child: Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width * .79,
                    color: const Color(0xff2e1437),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 120, top: 100),
                  child: Text(
                    '        Edit \n Transactions',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * .72,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 209, 209, 213),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Select the date :',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff480048),
                                  letterSpacing: 1),
                              textAlign: TextAlign.start,
                            ),
                            Container(
                              height: 50,
                              width: 180,
                              decoration: const BoxDecoration(
                                color: Color(0xff948e99),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      final _selectedDateTemp =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2021),
                                              lastDate: DateTime.now());
                                      if (_selectedDateTemp == null) {
                                        widget.value.date.toString();
                                      } else {
                                        setState(() {
                                          _selectedDate = _selectedDateTemp;
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.calendar_month,
                                      size: 30,
                                      color: Color(0xffe7eed0),
                                    ),
                                  ),
                                  Text(
                                    _selectedDate == null
                                        ? ""
                                        : DateFormat.yMMMd()
                                            .format(_selectedDate!),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xffe7eed0),
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Amount :',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff480048),
                                  letterSpacing: 1),
                            ),
                            Container(
                              height: 50,
                              width: 200,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                  ),
                                  color: Color(0xff948e99)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xffe7eed0),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.5,
                                  ),
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration.collapsed(
                                      hintText: widget.value.amount.toString(),
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.brown[300])),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Note :',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff480048),
                                  letterSpacing: 1),
                            ),
                            Container(
                              height: 110,
                              width: 200,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                  ),
                                  color: Color(0xff948e99)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15,top: 35),
                                child: TextFormField(
                                  style: const TextStyle(
                                    color: Color(0xffe7eed0),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2,
                                  ),
                                  controller: _purposeController,
                                  minLines: 2,
                                  maxLines: 5,
                                  decoration: InputDecoration.collapsed(
                                      hintText: widget.value.purpose.toString(),
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.brown[300])),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Categories :',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff480048),
                                  letterSpacing: 1),
                            ),
                            Container(
                              height: 50,
                              width: 200,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                  ),
                                  color: Color(0xff948e99)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: _selectedCategorytype ==
                                            widget.value.type
                                        ? Text(widget.value.category.name,style: const TextStyle(
                                                color: Color(0xffe7eed0)) ,)
                                        : const Text('Select a category',
                                            style: TextStyle(
                                                color: Color(0xffe7eed0))),
                                    value: _categoryID,
                                    dropdownColor: const Color(0xff948e99),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffe7eed0),
                                      fontSize: 19,
                                    ),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: (_selectedCategorytype ==
                                                CategoryType.income
                                            ? CategoryDB
                                                .instance
                                                .incomeCategoryListListener
                                                .value
                                            : CategoryDB
                                                .instance
                                                .expenseCategoryListListener
                                                .value)
                                        .map((e) {
                                      return DropdownMenuItem(
                                        value: e.id,
                                        child: Text(e.name),
                                        onTap: () {
                                          _selectedCategoryMOdel = e;
                                        },
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _categoryID = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            const Text(
                              'Change the type : ',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff480048),
                                  letterSpacing: 1),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ChoiceChip(
                                  elevation: 10,
                                  padding: const EdgeInsets.all(15),
                                  label: Text(
                                    'Income',
                                    style: TextStyle(
                                        color: _selectedCategorytype ==
                                                CategoryType.income
                                            ? Colors.white
                                            : Colors.black,
                                        letterSpacing: 2),
                                  ),
                                  selected: _selectedCategorytype ==
                                          CategoryType.income
                                      ? true
                                      : false,
                                  selectedColor: Colors.green,
                                  onSelected: (value) {
                                    setState(() {
                                      _selectedCategorytype =
                                          CategoryType.income;
                                      _categoryID = null;
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  elevation: 10,
                                  padding: const EdgeInsets.all(15),
                                  label: Text(
                                    'Expense',
                                    style: TextStyle(
                                        color: _selectedCategorytype ==
                                                CategoryType.expense
                                            ? Colors.white
                                            : Colors.black,
                                        letterSpacing: 2),
                                  ),
                                  selected: _selectedCategorytype ==
                                          CategoryType.expense
                                      ? true
                                      : false,
                                  selectedColor: Colors.red,
                                  onSelected: (value) {
                                    setState(() {
                                      _selectedCategorytype =
                                          CategoryType.expense;
                                      _categoryID = null;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Back ',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 177, 122, 12),
                                        fontSize: 16,
                                        letterSpacing: 2)),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    primary: Colors.white,
                                    elevation: 9),
                              ),
                            ),
                            SizedBox(
                              height: 45,
                              width: 180,
                              child: ElevatedButton(
                                onPressed: () {
                                  updateTransaction();
                                },
                                child: const Text('Update ',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 177, 122, 12),
                                        fontSize: 16,
                                        letterSpacing: 2)),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    primary: Colors.white,
                                    elevation: 9),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Future<void> updateTransaction() async {
    final _purpose = _purposeController.text.trim();
    final _amount = _amountController.text;
    final _parsedAmount = double.tryParse(_amount);

    final _model = TransactionModel(
        id: widget.value.id,
        date: _selectedDate!,
        amount: _parsedAmount!,
        purpose: _purpose,
        type: _selectedCategorytype!,
        category: _selectedCategoryMOdel!);

    await TransactionDB.instance.updateTransaction(widget.value.id, _model);
    Navigator.of(context).pop();
  }
}
