import 'package:every_rupee/class/notification_awsme.dart';
import 'package:every_rupee/db/category/category_db.dart';
import 'package:every_rupee/db/transactions/transaction_db.dart';
import 'package:every_rupee/model/category/category_model.dart';
import 'package:every_rupee/model/transactions/transaction_model.dart';
import 'package:every_rupee/screens/add_screens/exp_add.dart';
import 'package:every_rupee/screens/category.dart';
import 'package:every_rupee/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class AdTransaction extends StatefulWidget {
  const AdTransaction({Key? key}) : super(key: key);

  @override
  State<AdTransaction> createState() => _AdTransactionState();
}

class _AdTransactionState extends State<AdTransaction>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  dynamic _dateNow = DateTime.now();
  late String format;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().getCategories().then((value) {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  String? dropdownvalue;
  String? exdropdownvalue;

 
 
  CategoryModel? _selectedCategoryMOdel;

  final _puposeTextEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    ToastContext().init(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
       systemNavigationBarColor: Colors.black));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .24,
                  child: Stack(children: [
                    Image.asset(
                      'assets/images/add_trans_image.png',
                      height: MediaQuery.of(context).size.height * .14,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 55, left: 90),
                      child: Text(
                        'Add\n Transactions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'Trajan',
                            fontWeight: FontWeight.w900,
                            color: Color(0xff480048),
                            letterSpacing: 5),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 135, left: 150),
                      child: Text(
                        'Add the latest transaction.',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1),
                      ),
                    )
                  ]),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Container(
                height: MediaQuery.of(context).size.height * .69,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 209, 209, 213),
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
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
                              letterSpacing: 5),
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
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: ListView(
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          ' Date :',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff480048),
                                              letterSpacing: 1),
                                          textAlign: TextAlign.start,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            datePicker();
                                          },
                                          child: Container(
                                            height: height * .06,
                                            width: width * .52,
                                            decoration: const BoxDecoration(
                                              color: Color(0xff948e99),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12.0),
                                                bottomRight:
                                                    Radius.circular(12.0),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    datePicker();
                                                  },
                                                  icon: const Icon(
                                                    Icons.calendar_month,
                                                    size: 30,
                                                    color: Color(0xffe7eed0),
                                                  ),
                                                ),
                                                Text(
                                                  format = DateFormat('yMMMMd')
                                                      .format(_dateNow),
                                                  textScaleFactor: 1,
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
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                     
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          height: height * .06,
                                          width: width * .52,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12.0),
                                                bottomRight:
                                                    Radius.circular(12.0),
                                              ),
                                              color: Color(0xff948e99)),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 2.5,
                                                    color: Color(0xffe7eed0)),
                                                maxLines: 5,
                                                minLines: 1,
                                                controller:
                                                    _amountEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: const InputDecoration
                                                        .collapsed(
                                                    hintText: 'Enter the Amount',
                                                    hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: 2.5,
                                                        color:
                                                            Color(0xffe7eed0))),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          height: height * .13,
                                          width: width * .52,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12.0),
                                                bottomRight:
                                                    Radius.circular(12.0),
                                              ),
                                              color: Color(0xff948e99)),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 1,
                                                    color: Color(0xffe7eed0)),
                                                minLines: 2,
                                                maxLines: 5,
                                                controller:
                                                    _puposeTextEditingController,
                                                decoration: const InputDecoration
                                                        .collapsed(
                                                    hintText: 'Transaction notes',
                                                    hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: 2,
                                                        color:
                                                            Color(0xffe7eed0))),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            height: height * .06,
                                            width: width * .52,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(12.0),
                                                  bottomRight:
                                                      Radius.circular(12.0),
                                                ),
                                                color: Color(0xff948e99)),
                                            child: CategoryDB
                                                    .instance
                                                    .incomeCategoryListListener
                                                    .value
                                                    .isNotEmpty
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                        isExpanded: true,
                                                        hint: const Text(
                                                          'Select Category',
                                                          style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              color: Color(
                                                                  0xffe7eed0)),
                                                        ),
                                                        value: dropdownvalue,
                                                        dropdownColor:
                                                            const Color(
                                                                0xff948e99),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xffe7eed0),
                                                            fontSize: 19,
                                                            letterSpacing: 1),
                                                        icon: const Icon(Icons
                                                            .keyboard_arrow_down),
                                                        items: CategoryDB()
                                                            .incomeCategoryListListener
                                                            .value
                                                            .map((e) {
                                                          return DropdownMenuItem(
                                                            value: e.id,
                                                            child: Text(e.name),
                                                            onTap: () {
                                                              _selectedCategoryMOdel =
                                                                  e;
                                                            },
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            dropdownvalue =
                                                                newValue!;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                : TextButton.icon(
                                                    label: const Text(
                                                      'Create a category',
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xffe7eed0)),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const CategoryScreen()));
                                                    },
                                                    icon: const Icon(
                                                      Icons.add,
                                                      color: Color(0xffe7eed0),
                                                    ))),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: height * .052,
                                          width: width * .29,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Back ',
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 177, 122, 12),
                                                    fontSize: 16,
                                                    letterSpacing: 2)),
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14)),
                                                primary: Colors.white,
                                                elevation: 10),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * .052,
                                          width: width * .56,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                addTransaction();
                                                TransactionDB.instance
                                                    .refresh();
                                              },
                                              child: const Text(
                                                  'Add to Transaction ',
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 177, 122, 12),
                                                      fontSize: 16,
                                                      letterSpacing: 2)),
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14)),
                                                  primary: Colors.white,
                                                  elevation: 10)),
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
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: const ExpenseAddTransaction(),
                          ),
                        ],
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

  datePicker() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: _dateNow,
        firstDate: DateTime(2021),
        lastDate: DateTime.now());
    setState(() {
      newDate == null ? _dateNow : _dateNow = newDate;
    });
  }

  addTransaction() {
    final _purposeText = _puposeTextEditingController.text.trim();
    final _amountText = _amountEditingController.text;
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    if (_purposeText.isEmpty) {
      return pop();
    }
    if (_amountText.isEmpty) {
      return pop();
    }

    if (_selectedCategoryMOdel == null) {
      return pop();
    }

    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }

    final _model = TransactionModel(
        date: _dateNow,
        amount: _parsedAmount,
        purpose: _purposeText,
        type: CategoryType.income,
        category: _selectedCategoryMOdel!,
        id: id);

    TransactionDB.instance.addTransaction(_model);
    checkNotification();
    showToast("Added to Transactions", gravity: Toast.center);
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: 2, gravity: gravity);
    Navigator.of(context).pop();
  }

  void pop() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 600),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 215, 6, 6),
        margin: EdgeInsets.all(20),
        content: Text(
          'All fields are required',
          style: TextStyle(letterSpacing: 2),
        )));
  }
  
}
checkNotification() async{
    if(notificationListener.value==true){
      createPersistentNotification();

    }
  }


