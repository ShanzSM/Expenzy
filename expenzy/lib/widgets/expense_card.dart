import 'package:expenzy/constant/colors.dart';
import 'package:expenzy/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  const ExpenseCard(
      {super.key,
      required this.title,
      required this.description,
      required this.amount,
      required this.category,
      required this.date,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kWhite,
        boxShadow: [
          BoxShadow(
              color: kGrey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 1)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: expenseCategoryColors[category]!.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              expenseCategoryImages[category]!,
              height: 40,
              width: 40,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: kBlack),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  description,
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500, color: kGrey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "- Rs.${amount.toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: kRed),
              ),
              Text(
                DateFormat.jm().format(date),
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500, color: kGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
