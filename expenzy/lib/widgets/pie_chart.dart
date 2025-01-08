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
  final double percentage;

  const Chart({
    super.key,
    required this.expensecategoryTotals,
    required this.incomecategoryTotals,
    required this.isExpense,
    required this.percentage,
  });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
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
                "${widget.percentage.toStringAsFixed(1)}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "of 100%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
