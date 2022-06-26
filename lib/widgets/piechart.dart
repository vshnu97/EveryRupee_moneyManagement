import 'package:every_rupee/db/transactions/transaction_db.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class TransactionChart extends StatefulWidget {
  const TransactionChart({Key? key}) : super(key: key);

  @override
  State<TransactionChart> createState() => _TransactionChartState();
}

class _TransactionChartState extends State<TransactionChart> {
  Map<String, double> statistics = {
    "Income": TransactionDB.instance.incomeTotal.value,
    "Expense": TransactionDB.instance.expenseTotal.value,
    "Balance Amount": TransactionDB.instance.totalamount.value,
  };

  
   

  @override
  Widget build(BuildContext context) {
    return (PieChart(
      dataMap: statistics,
      animationDuration: const Duration(seconds: 3),
      chartLegendSpacing: 32,
      chartType: ChartType.ring,
      ringStrokeWidth:  MediaQuery.of(context).size.height*.04,
      chartRadius: MediaQuery.of(context).size.height*.2,
      chartValuesOptions: const ChartValuesOptions(
        showChartValuesInPercentage: true,
      ),
      legendOptions: const LegendOptions(
          legendShape: BoxShape.circle,
          legendPosition: LegendPosition.top,
          showLegendsInRow: true),
 
  
    ));
  }
}
