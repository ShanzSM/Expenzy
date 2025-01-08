import 'package:expenzy/constant/colors.dart';
import 'package:expenzy/constant/constants.dart';
import 'package:expenzy/screens/onboarding_screen.dart';
import 'package:expenzy/services/expense_service.dart';
import 'package:expenzy/services/income_service.dart';
import 'package:expenzy/services/user_services.dart';
import 'package:expenzy/widgets/income_expence_card.dart';
import 'package:expenzy/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  String username = "";
  String email = "";
  @override
  void initState() {
    super.initState();
    //get the user details from the shared preferences
    UserServices.getUserData().then((value) {
      //check if the user details are not null
      if (value['username'] != null && value['email'] != null) {
        //set the username and email to the state
        setState(() {
          username = value['username']!;
          email = value['email']!;
        });
      }
    });
  }

  //open scffold messenger for logout
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: kLightGrey,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(kDefalutPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Are you sure you want to log out?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kGrey,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kGreen),
                    ),
                    onPressed: () async {
                      // Clear the user details from shared preferences
                      await UserServices.clearUserDetails();

                      //remove all expenses and incomes
                      if (context.mounted == true) {
                        await ExpenceService().deleteAllExpenses(context);
                        await IncomeServices().deleteAllIncomes(context);
                      }

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        color: kWhite,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kRed),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(
                        color: kWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    Column(
                      children: [
                        Text(
                          " $username",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          " $email",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: kGrey),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: kMainColor,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                ProfileCard(
                  icon: Icons.wallet,
                  title: "My Wallet",
                  color: kMainColor,
                ),
                ProfileCard(
                  icon: Icons.settings,
                  title: "Settings",
                  color: kYellow,
                ),
                ProfileCard(
                  icon: Icons.download_outlined,
                  title: "Export",
                  color: kGreen,
                ),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: ProfileCard(
                    icon: Icons.download_outlined,
                    title: "Log Out",
                    color: kRed,
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
