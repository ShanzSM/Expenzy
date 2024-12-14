import 'package:expenzy/constant/colors.dart';
import 'package:expenzy/constant/constants.dart';
import 'package:expenzy/models/expense_model.dart';
import 'package:expenzy/models/income_model.dart';
import 'package:expenzy/widgets/expense_card.dart';
import 'package:expenzy/widgets/income_card.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expense> expensesList;
  final List<Income> incomesList;
  final void Function(Expense) onDismissedExpense;
  final void Function(Income) onDismissedIncome;
  const TransactionScreen({
    super.key,
    required this.expensesList,
    required this.incomesList,
    required this.onDismissedExpense,
    required this.onDismissedIncome,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kDefalutPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "See Your Financial Report",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kMainColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Expenses",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: kBlack),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.expensesList.length,
                        itemBuilder: (context, index) {
                          final expense = widget.expensesList[index];
                          return Dismissible(
                            key: ValueKey(expense),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              widget.onDismissedExpense(expense);
                            },
                            child: ExpenseCard(
                              title: expense.title,
                              description: expense.description,
                              amount: expense.amount,
                              category: expense.category,
                              date: expense.date,
                              time: expense.time,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Incomes",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: kBlack),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.33,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.incomesList.length,
                        itemBuilder: (context, index) {
                          final income = widget.incomesList[index];
                          return Dismissible(
                            key: ValueKey(income),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              widget.onDismissedIncome(income);
                            },
                            child: IncomeCard(
                                title: income.title,
                                description: income.description,
                                amount: income.amount,
                                category: income.category,
                                date: income.date,
                                time: income.time),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
