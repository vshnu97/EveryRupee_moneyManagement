import 'package:every_rupee/db/category/category_db.dart';

import 'package:every_rupee/model/category/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  String title = 'Delete';
  String subtitle = 'Are you sure ?';
  String lottie = 'assets/JSON/delete.json';

  final _nameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    ToastContext().init(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 104, left: 100),
                    child: Container(
                      height: height * .003,
                      width: width * .68,
                      color: const Color(0xff948e99),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 67),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Trajan',
                          fontWeight: FontWeight.w800,
                          color: Color(0xff480048),
                          letterSpacing: 6.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 250,
                    ),
                    child: Image.asset('assets/images/categoryImage.png'),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TabBar(
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
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: height * .067,
                        width: width * .67,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                            color: Color(0xff948e99)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                              controller: _nameEditingController,
                              decoration: const InputDecoration.collapsed(
                                  hintText: 'New Income category..',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.5,
                                      color: Color(0xffe7eed0))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .05,
                        width: width * .27,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            final _name = _nameEditingController.text;
                            if (_name.isEmpty) {
                              return;
                            } else {
                              final _category = CategoryModel(
                                  id: DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                  name: _name,
                                  type: CategoryType.income);
                              CategoryDB.instance.insertCategory(_category);
                              _nameEditingController.clear();
                            }
                            showToast("New Category added",
                                gravity: Toast.center);
                          },
                          child: const Text('ADD + ',
                              textScaleFactor: 1,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 177, 122, 12),
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              primary: Colors.white,
                              elevation: 15),
                        ),
                      ),
                      Container(
                          height: height * .45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 209, 209, 213),
                              borderRadius: BorderRadius.circular(30)),
                          child: ValueListenableBuilder(
                              valueListenable:
                                  CategoryDB().incomeCategoryListListener,
                              builder: (BuildContext context,
                                  List<CategoryModel> newlist, Widget? _) {
                                return CategoryDB
                                        .instance
                                        .incomeCategoryListListener
                                        .value
                                        .isNotEmpty
                                    ? GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisExtent: 75,
                                                childAspectRatio: 3),
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final category = newlist[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  17.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  17.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  17.0)),
                                                  color: Color(0xFF90c695)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          category.name,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 17,
                                                              letterSpacing: 1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  dialogShow(
                                                                      context,
                                                                      category
                                                                          .id));
                                                        },
                                                        icon: const Icon(
                                                          Icons.cancel_outlined,
                                                          color: Color.fromARGB(
                                                              255, 157, 18, 8),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: newlist.length,
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Lottie.asset(
                                              'assets/JSON/lottie.json',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .2),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          const Text(
                                            'No Categories added',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.5,
                                                color: Color.fromARGB(
                                                    255, 157, 10, 10)),
                                          )
                                        ],
                                      );
                              }))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: height * .067,
                        width: width * .67,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                            color: Color(0xff948e99)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _nameEditingController,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                              decoration: const InputDecoration.collapsed(
                                  hintText: 'New Expense category..',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1,
                                      color: Color(0xffe7eed0))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .05,
                        width: width * .27,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            final _name = _nameEditingController.text;
                            if (_name.isEmpty) {
                              return;
                            } else {
                              final _category = CategoryModel(
                                  id: DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                  name: _name,
                                  type: CategoryType.expense);
                              CategoryDB.instance.insertCategory(_category);
                              _nameEditingController.clear();
                            }
                            showToast("New Category added",
                                gravity: Toast.center);
                          },
                          child: const Text('ADD + ',
                              textScaleFactor: 1,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 177, 122, 12),
                                  letterSpacing: 2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              primary: Colors.white,
                              elevation: 15),
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * .45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 209, 209, 213),
                              borderRadius: BorderRadius.circular(30)),
                          child: ValueListenableBuilder(
                              valueListenable:
                                  CategoryDB().expenseCategoryListListener,
                              builder: (BuildContext context,
                                  List<CategoryModel> newlist, Widget? _) {
                                return CategoryDB
                                        .instance
                                        .expenseCategoryListListener
                                        .value
                                        .isNotEmpty
                                    ? GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisExtent: 75,
                                                childAspectRatio: 3),
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final category = newlist[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(17.0),
                                                    bottomRight:
                                                        Radius.circular(17.0),
                                                  ),
                                                  color: Color.fromARGB(
                                                      255, 201, 127, 133)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          category.name,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 17,
                                                              letterSpacing: 1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  dialogShow(
                                                                      context,
                                                                      category
                                                                          .id));
                                                        },
                                                        icon: const Icon(
                                                          Icons.cancel_outlined,
                                                          color: Color.fromARGB(
                                                              255, 157, 18, 8),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: newlist.length)
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Lottie.asset(
                                              'assets/JSON/lottie.json',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .2),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          const Text(
                                            'No Categories added',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.5,
                                                color: Color.fromARGB(
                                                    255, 157, 10, 10)),
                                          )
                                        ],
                                      );
                              }))
                    ],
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: 2, gravity: gravity);
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
                          CategoryDB.instance.deleteCategory(index);
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
}
