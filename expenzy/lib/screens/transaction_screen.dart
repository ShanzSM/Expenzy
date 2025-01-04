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
          padding: const EdgeInsets.all(kDefalutPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "See Your Financial Report",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kMainColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Expenses",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: kBlack),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.expensesList.isEmpty
                          ? const Text(
                              "No expenses added yet, add some expenses to see here",
                              style: TextStyle(
                                fontSize: 16,
                                color: kGrey,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
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
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Incomes",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: kBlack),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.33,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.incomesList.isEmpty
                          ? const Text(
                              "No incomes added yet, add some incomes to see here",
                              style: TextStyle(
                                fontSize: 16,
                                color: kGrey,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
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
