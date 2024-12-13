import 'package:expenzy/constant/colors.dart';
import 'package:expenzy/models/expense_model.dart';
import 'package:expenzy/screens/add_new_screen.dart';
import 'package:expenzy/screens/budget_screen.dart';
import 'package:expenzy/screens/home_screen.dart';
import 'package:expenzy/screens/profile_screen.dart';
import 'package:expenzy/screens/transaction_screen.dart';
import 'package:expenzy/services/expense_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;
  List<Expense> expenseList = [];
  void fetchAllExpenses() async {
    List<Expense> loadedExpenses = await ExpenceService().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
      print(expenseList.length);
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

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchAllExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    //screen list
    final List<Widget> pages = [
      HomeScreen(),
      TransactionScreen(),
      AddNewScreen(
        addExpense: addNewExpense,
      ),
      BudgetScreen(),
      profileScreen(),
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
            TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_rounded,
            ),
            label: "Transaction",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration:
                  BoxDecoration(color: kMainColor, shape: BoxShape.circle),
              child: Icon(
                Icons.add,
                color: kWhite,
                size: 30,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.rocket,
            ),
            label: "Budget",
          ),
          BottomNavigationBarItem(
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
