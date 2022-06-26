// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:every_rupee/model/category/category_model.dart';
import 'package:every_rupee/model/transactions/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const transactionName = 'transaction-db';
// ignore: constant_identifier_names
const categoryName = 'category-database';

abstract class TransactionDbFunction {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransaction();
  Future<void> deleteTransaction(String ide);
  Future<void> updateTransaction(String id, TransactionModel obj);
  Future<void> resetTransactrion();
}

class TransactionDB implements TransactionDbFunction {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> incomeTransactionListNotiFier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expenseTransactionListNotiFier =
      ValueNotifier([]);
  ValueNotifier<double> incomeTotal = ValueNotifier(0);
  ValueNotifier<double> expenseTotal = ValueNotifier(0);
  ValueNotifier<double> totalamount = ValueNotifier(0);

  ValueNotifier<List<TransactionModel>> todayListNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> yesterdayListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> monthelyListNotifier =
      ValueNotifier([]);

  String todayDate = DateFormat.yMd().format(DateTime.now());
  String yesterdayDate =
      DateFormat.yMd().format(DateTime.now().subtract(const Duration(days: 1)));
  String monthlyDate = DateFormat.yMd()
      .format(DateTime.now().subtract(const Duration(days: 30)));

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(transactionName);
    await _db.put(obj.id, obj);
    refresh();
  }

  Future<void> refresh() async {
    var _list = await getAllTransaction();
    _list = _list.reversed.toList();
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
    incomeTransactionListNotiFier.value.clear();
    expenseTransactionListNotiFier.value.clear();
    incomeTotal.value = 0;
    expenseTotal.value = 0;
    totalamount.value = 0;

    Future.forEach(_list, (TransactionModel data) {
      totalamount.value = totalamount.value + data.amount;

      if (data.type == CategoryType.income) {
        incomeTransactionListNotiFier.value.add(data);
        incomeTotal.value = incomeTotal.value + data.amount;
      } else {
        expenseTransactionListNotiFier.value.add(data);
        expenseTotal.value = expenseTotal.value + data.amount;
      }
    });
    totalamount.value = incomeTotal.value - expenseTotal.value;
    incomeTransactionListNotiFier.notifyListeners();
    expenseTransactionListNotiFier.notifyListeners();
    incomeTotal.notifyListeners();
    expenseTotal.notifyListeners();
    totalamount.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransaction() async {
    final _db = await Hive.openBox<TransactionModel>(transactionName);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String ide) async {
    final _db = await Hive.openBox<TransactionModel>(transactionName);
    await _db.delete(ide);
    refresh();
  }

  @override
  Future<void> updateTransaction(id, obj) async {
    final _db = await Hive.openBox<TransactionModel>(transactionName);
    _db.put(id, obj);
    refresh();
  }

  @override
  Future<void> resetTransactrion() async {
    final preferences = await SharedPreferences.getInstance();
    final _db = await Hive.openBox<TransactionModel>(transactionName);
    final _categoryDB = await Hive.openBox<CategoryModel>(categoryName);
    await _categoryDB.clear();
    preferences.clear();
    await _db.clear();
    await refresh();
  }

  Future<void> sortTransaction(List<TransactionModel> selectedlist) async {
    todayListNotifier.value.clear();
    yesterdayListNotifier.value.clear();
    monthelyListNotifier.value.clear();
    await Future.forEach(selectedlist, (TransactionModel singleModel) {
      String eachModelDate = DateFormat.yMd().format(singleModel.date);

      if (todayDate == eachModelDate) {
        todayListNotifier.value.add(singleModel);
      }
      if (yesterdayDate == eachModelDate) {
        yesterdayListNotifier.value.add(singleModel);
      }
      if (monthlyDate == eachModelDate) {
        monthelyListNotifier.value.add(singleModel);
      }
    });
    
    todayListNotifier.notifyListeners();
  
    yesterdayListNotifier.notifyListeners();
   
    monthelyListNotifier.notifyListeners();
  }
}
