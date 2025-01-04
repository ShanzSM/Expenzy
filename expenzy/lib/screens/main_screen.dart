import 'package:expenzy/constant/colors.dart';
import 'package:expenzy/models/expense_model.dart';
import 'package:expenzy/models/income_model.dart';
import 'package:expenzy/screens/add_new_screen.dart';
import 'package:expenzy/screens/budget_screen.dart';
import 'package:expenzy/screens/home_screen.dart';
import 'package:expenzy/screens/profile_screen.dart';
import 'package:expenzy/screens/transaction_screen.dart';
import 'package:expenzy/services/expense_service.dart';
import 'package:expenzy/services/income_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;
  List<Expense> expenseList = [];
  List<Income> incomeList = [];
  //function to fetch expense
  void fetchAllExpenses() async {
    List<Expense> loadedExpenses = await ExpenceService().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
    });
  }

  //function to fetch all incomes
  void fetchAllIncomes() async {
    List<Income> loadedIncome = await IncomeServices().loadIncomes();
    setState(() {
      incomeList = loadedIncome;
    });
  }

  //function add new expense
  void addNewExpense(Expense newExpense) {
    ExpenceService().saveExpense(newExpense, context);
    //update the list of expense
    setState(() {
      expenseList.add(newExpense);
    });
  }

  //function add new income
  void addNewIncome(Income newIncome) {
    IncomeServices().saveIncome(newIncome, context);
    //update the list of income
    setState(() {
      incomeList.add(newIncome);
    });
  }

  //function to remove expense
  void removeExpense(Expense expense) {
    ExpenceService().deleteExpense(expense.id, context);
    setState(() {
      expenseList.remove(expense);
    });
  }

  //function to remove Income
  void removeIncome(Income income) {
    IncomeServices().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchAllExpenses();
      fetchAllIncomes();
    });
  }

  //category total expenses
  Map<ExpenseCategory, double> calculateExpenseCategories() {
    Map<ExpenseCategory, double> categoryTotals = {
      ExpenseCategory.food: 0,
      ExpenseCategory.health: 0,
      ExpenseCategory.shopping: 0,
      ExpenseCategory.subscription: 0,
      ExpenseCategory.transport: 0,
    };
    for (Expense expense in expenseList) {
      categoryTotals[expense.category] =
          categoryTotals[expense.category]! + expense.amount;
    }
    return categoryTotals;
  }

  //category total incomes
  Map<IncomeCategory, double> calculateIncomeCategories() {
    Map<IncomeCategory, double> categoryTotals = {
      IncomeCategory.freelance: 0,
      IncomeCategory.passive: 0,
      IncomeCategory.salary: 0,
      IncomeCategory.sales: 0,
    };
    for (Income income in incomeList) {
      categoryTotals[income.category] =
          categoryTotals[income.category]! + income.amount;
    }
    return categoryTotals;
  }

  @override
  Widget build(BuildContext context) {
    //screen list
    final List<Widget> pages = [
      BudgetScreen(
          expenseCategoryTotals: calculateExpenseCategories(),
          incomeCategoryTotals: calculateIncomeCategories()),
      HomeScreen(
        expenseList: expenseList,
        incomeList: incomeList,
      ),
      AddNewScreen(
        addExpense: addNewExpense,
        addIncome: addNewIncome,
      ),
      TransactionScreen(
        expensesList: expenseList,
        incomesList: incomeList,
        onDismissedExpense: removeExpense,
        onDismissedIncome: removeIncome,
      ),
      const profileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
            print(_currentPageIndex);
          });
        },
        selectedLabelStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.list_rounded,
            ),
            label: "Transaction",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: kMainColor, shape: BoxShape.circle),
              child: const Icon(
                Icons.add,
                color: kWhite,
                size: 30,
              ),
            ),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.rocket,
            ),
            label: "Budget",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Profile",
          ),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
