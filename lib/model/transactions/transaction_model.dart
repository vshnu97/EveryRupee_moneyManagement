import 'package:every_rupee/model/category/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
 part 'transaction_model.g.dart';



@HiveType(typeId: 3)
class TransactionModel {


  @HiveField(0)
   final String id;
 

   @HiveField(1)
  final double amount;

   @HiveField(2)
  final String purpose;

   @HiveField(3)
  final CategoryType type;

   @HiveField(4)
  final CategoryModel category;

  @HiveField(5)
    final DateTime date;

  TransactionModel(
   
      {required this.id, 
        required this.date,
      required this.amount,
      required this.purpose,
      required this.type,
      required this.category});

}