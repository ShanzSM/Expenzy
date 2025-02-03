import 'package:expenzy/constant/colors.dart';
import 'package:expenzy/constant/constants.dart';
import 'package:expenzy/models/expense_model.dart';
import 'package:expenzy/models/income_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  final Map<ExpenseCategory, double> expensecategoryTotals;
  final Map<IncomeCategory, double> incomecategoryTotals;
  final bool isExpense;

  const Chart({
    super.key,
    required this.expensecategoryTotals,
    required this.incomecategoryTotals,
    required this.isExpense,
  });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  // Calculate total income
  double getTotalIncome() {
    return widget.incomecategoryTotals.values
        .fold(0, (sum, value) => sum + value);
  }

  // Calculate total expense
  double getTotalExpense() {
    return widget.expensecategoryTotals.values
        .fold(0, (sum, value) => sum + value);
  }

  // Calculate rest (total Income - total Expense)
  String getRestValue() {
    double totalIncome = getTotalIncome();
    double totalExpense = getTotalExpense();
    double rest = totalIncome - totalExpense;
    return "RS. ${rest.toStringAsFixed(2)}"; // Adjust the formatting as needed
  }

  // Get sections for pie chart
  List<PieChartSectionData> getSection() {
    if (widget.isExpense) {
      return widget.expensecategoryTotals.entries.map((entry) {
        return PieChartSectionData(
          color: expenseCategoryColors[entry.key],
          value: entry.value,
          showTitle: false,
          radius: 60,
        );
      }).toList();
    } else {
      return widget.incomecategoryTotals.entries.map((entry) {
        return PieChartSectionData(
          color: incomeCategoryColors[entry.key],
          value: entry.value,
          showTitle: false,
          radius: 60,
        );
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 70,
      startDegreeOffset: -90,
      sections: getSection(),
      borderData: FlBorderData(show: false),
    );
    return Container(
      height: 250,
      padding: EdgeInsets.all(kDefalutPadding),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getRestValue(), // Displaying the rest value here
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Remaining \nBalance",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
