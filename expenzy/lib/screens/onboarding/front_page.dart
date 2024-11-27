import 'package:expenzy/constant/colors.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/logo.png",
          width: 150,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            "Expenzy",
            style: TextStyle(
              fontSize: 40,
              color: kMainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
