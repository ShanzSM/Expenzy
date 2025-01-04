import 'package:flutter/material.dart';
import 'package:expenzy/constant/colors.dart';
import 'package:expenzy/constant/constants.dart';
import 'package:expenzy/models/expense_model.dart';
import 'package:expenzy/models/income_model.dart';
import 'package:expenzy/services/user_services.dart';
import 'package:expenzy/widgets/expense_card.dart';
import 'package:expenzy/widgets/income_card.dart';
import 'package:expenzy/widgets/income_expence_card.dart';
import 'package:expenzy/widgets/line_chart.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final List<Income> incomeList;

  const HomeScreen({
    super.key,
    required this.expenseList,
    required this.incomeList,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
  double expensetotal = 0;
  double incometotal = 0;

  List<dynamic> recentTransactions = [];

  @override
  void initState() {
    super.initState();

    // Get username from shared preferences
    UserServices.getUserData().then(
      (value) {
        if (value["username"] != null) {
          setState(() {
            username = value["username"]!;
          });
        }
      },
    );

    // Calculate totals and prepare recent transactions
    setState(() {
      expensetotal =
          widget.expenseList.fold(0, (sum, expense) => sum + expense.amount);
      incometotal =
          widget.incomeList.fold(0, (sum, income) => sum + income.amount);

      // Combine and sort transactions by date and time
      recentTransactions = [
        ...widget.expenseList.map((expense) => {
              "type": "expense",
              "data": expense,
            }),
        ...widget.incomeList.map((income) => {
              "type": "income",
              "data": income,
            })
      ];
      recentTransactions.sort((a, b) {
        final dateA = a["data"].date;
        final dateB = b["data"].date;
        final timeA = a["data"].time;
        final timeB = b["data"].time;
        return dateB.compareTo(dateA) != 0
            ? dateB.compareTo(dateA)
            : timeB.compareTo(timeA);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                height: MediaQuery.of(context).size.height * 0.27,
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.15),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // User profile
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                const AssetImage("assets/images/user.jpg"),
                          ),
                          Text(
                            " $username",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              color: kMainColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Income and Expense Summary
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpenceCard(
                            title: "Income",
                            amount: incometotal,
                            imageUrl: "assets/images/income.png",
                            bgcolor: kGreen,
                          ),
                          IncomeExpenceCard(
                            title: "Expenses",
                            amount: expensetotal,
                            imageUrl: "assets/images/expense.png",
                            bgcolor: kRed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Spend Frequency Section
              Padding(
                padding: const EdgeInsets.all(kDefalutPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Spend Frequency",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LineChartSample(),
                  ],
                ),
              ),
              // Recent Transactions Section
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefalutPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      reverse: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recentTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = recentTransactions[index];
                        if (transaction["type"] == "expense") {
                          final expense = transaction["data"];
                          return ExpenseCard(
                            title: expense.title,
                            description: expense.description,
                            amount: expense.amount,
                            category: expense.category,
                            date: expense.date,
                            time: expense.time,
                          );
                        } else {
                          final income = transaction["data"];
                          return IncomeCard(
                            title: income.title,
                            description: income.description,
                            amount: income.amount,
                            category: income.category,
                            date: income.date,
                            time: income.time,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
