import 'package:expenzy/constant/colors.dart';
import 'package:expenzy/constant/constants.dart';
import 'package:expenzy/models/expense_model.dart';
import 'package:expenzy/models/income_model.dart';
import 'package:expenzy/services/expense_service.dart';
import 'package:expenzy/services/income_service.dart';
import 'package:expenzy/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatefulWidget {
  final Function(Expense) addExpense;
  final Function(Income) addIncome;
  const AddNewScreen({
    super.key,
    required this.addExpense,
    required this.addIncome,
  });

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  int _selectedMethod = 0;

  ExpenseCategory _expenseCategory = ExpenseCategory.Food;
  IncomeCategory _incomeCategory = IncomeCategory.Salary;
  DateTime _selecteddate = DateTime.now();
  DateTime _selectedTime = DateTime.now();
//text controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  //dispose controllers when the widget is disposed to avoid memory leaks
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethod == 0 ? kRed : kGreen,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefalutPadding),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                // Toggle Buttons for Expense and Income
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefalutPadding),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kWhite,
                    ),
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethod = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethod == 1 ? kWhite : kRed,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            child: Text(
                              "Expense",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _selectedMethod == 1 ? kBlack : kWhite,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethod = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethod == 0 ? kWhite : kGreen,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            child: Text(
                              "Income",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _selectedMethod == 0 ? kBlack : kWhite,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Amount Field
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefalutPadding),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "How Much?",
                          style: TextStyle(
                              fontSize: 20,
                              color: kLightGrey,
                              fontWeight: FontWeight.w500),
                        ),
                        TextField(
                          controller: _amountController,
                          style: const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: kWhite,
                          ),
                          decoration: const InputDecoration(
                            hintText: "0",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: kWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Form Section
                Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.25),
                  padding: const EdgeInsets.all(kDefalutPadding),
                  decoration: const BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kDefalutPadding),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          DropdownButtonFormField(
                            items: _selectedMethod == 0
                                ? ExpenseCategory.values.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name),
                                    );
                                  }).toList()
                                : IncomeCategory.values.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name),
                                    );
                                  }).toList(),
                            value: _selectedMethod == 0
                                ? _expenseCategory
                                : _incomeCategory,
                            onChanged: (value) {
                              setState(() {
                                _selectedMethod == 0
                                    ? _expenseCategory =
                                        value as ExpenseCategory
                                    : _incomeCategory = value as IncomeCategory;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _titleController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter The Title";
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Title",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter The Discription";
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _amountController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter The Amount";
                              }
                              double? amount = double.tryParse(value);
                              if (amount == null || amount <= 0) {
                                return "Please Enter The Valid amount";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Amount",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // date and time picker button
                          //date picker
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2050),
                                  ).then((Value) {
                                    if (Value != null) {
                                      setState(() {
                                        _selecteddate = Value;
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: kMainColor),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          color: kWhite,
                                        ),
                                        Text(
                                          "Select Date",
                                          style: TextStyle(
                                              color: kWhite, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd().format(_selecteddate),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: kGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ), // Time picker
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedTime = DateTime(
                                          _selecteddate.year,
                                          _selecteddate.month,
                                          _selecteddate.day,
                                          value.hour,
                                          value.minute,
                                        );
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: kYellow),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: kWhite,
                                        ),
                                        Text(
                                          "Select Time",
                                          style: TextStyle(
                                              color: kWhite, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(
                                  _selectedTime,
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: kGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          Divider(
                            color: kGrey.withOpacity(0.5),
                            thickness: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 2, 1),
                            child: GestureDetector(
                              onTap: () async {
                                if (_formkey.currentState!.validate()) {
                                  if (_selectedMethod == 0) {
                                    // Save expense data
                                    List<Expense> loadedExpenses =
                                        await ExpenceService().loadExpenses();

                                    // Create the expense to store
                                    Expense expense = Expense(
                                      id: loadedExpenses.length + 1,
                                      title: _titleController.text,
                                      amount:
                                          double.parse(_amountController.text),
                                      category: _expenseCategory,
                                      date: _selecteddate,
                                      time: _selectedTime,
                                      description: _descriptionController.text,
                                    );

                                    widget.addExpense(expense);

                                    // Clear the fields
                                    _amountController.clear();
                                    _titleController.clear();
                                    _descriptionController.clear();
                                  } else if (_selectedMethod == 1) {
                                    // Save income data
                                    List<Income> loadedIncome =
                                        await IncomeServices().loadIncomes();

                                    // Create the new income
                                    Income income = Income(
                                      id: loadedIncome.length + 1,
                                      title: _titleController.text,
                                      amount:
                                          double.parse(_amountController.text),
                                      category: _incomeCategory,
                                      date: _selecteddate,
                                      time: _selectedTime,
                                      description: _descriptionController.text,
                                    );

                                    widget.addIncome(income);

                                    // Clear the fields
                                    _amountController.clear();
                                    _titleController.clear();
                                    _descriptionController.clear();
                                  }

                                  // Reset to default method
                                  setState(() {
                                    _selectedMethod = 0;
                                  });
                                }
                              },
                              child: CustomButton(
                                buttonName: "Add",
                                buttonColor:
                                    _selectedMethod == 0 ? kRed : kGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
