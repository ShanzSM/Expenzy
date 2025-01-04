import 'package:expenzy/constant/colors.dart';
import 'package:expenzy/constant/constants.dart';
import 'package:expenzy/models/expense_model.dart';
import 'package:expenzy/models/income_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class chart extends StatefulWidget {
  final Map<ExpenseCategory, double> expensecategoryTotals;
  final Map<IncomeCategory, double> incomecategoryTotals;
  final bool isExpense;
  const chart(
      {super.key,
      required this.expensecategoryTotals,
      required this.incomecategoryTotals,
      required this.isExpense});

  @override
  State<chart> createState() => _chartState();
}

class _chartState extends State<chart> {
  //section data
  List<PieChartSectionData> getSection() {
    if (widget.isExpense) {
      return [
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.food],
          value: widget.expensecategoryTotals[ExpenseCategory.food] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.health],
          value: widget.expensecategoryTotals[ExpenseCategory.health] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.shopping],
          value: widget.expensecategoryTotals[ExpenseCategory.shopping] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.subscription],
          value:
              widget.expensecategoryTotals[ExpenseCategory.subscription] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.transport],
          value: widget.expensecategoryTotals[ExpenseCategory.transport] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.freelance],
          value: widget.incomecategoryTotals[IncomeCategory.freelance] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.passive],
          value: widget.incomecategoryTotals[IncomeCategory.passive] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.salary],
          value: widget.incomecategoryTotals[IncomeCategory.salary] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.sales],
          value: widget.incomecategoryTotals[IncomeCategory.sales] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
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
                "70%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "of 100%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kGrey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
