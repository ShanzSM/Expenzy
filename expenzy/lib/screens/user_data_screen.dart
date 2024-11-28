import 'package:expenzy/constant/colors.dart';
import 'package:expenzy/constant/constants.dart';
import 'package:expenzy/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  @override
  void dispose() {
    _userNameController.dispose();
    _EmailController.dispose();
    _PasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  bool _rememberMe = false;
  //Form key for Form validation
  final _formKey = GlobalKey<FormState>();
  //controller for the text from feild
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kDefalutPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Enter Your \nPersonal Details",
                  style: TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 60,
                ),
                //form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //form feild to the user
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {
                          //check wheather the user entered a valid user name
                          if (value!.isEmpty) {
                            return "please Enter Your Name";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: _EmailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please Enter yout Email";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: _PasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please Enter your Password";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter your Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please Enter the Same password";
                          }
                        },
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Your Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Text(
                            "Remember me for the next time",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kGrey),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              activeColor: kMainColor,
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            //form is valid ,process data
                            String username = _userNameController.text;
                            String email = _EmailController.text;
                            String password = _PasswordController.text;
                            String confirmpassword =
                                _confirmPasswordController.text;
                            print(
                                "$username $email $password $confirmpassword");
                          }
                        },
                        child: CustomButton(
                          buttonName: "Next",
                          buttonColor: kMainColor,
                        ),
                      ),
                    ],
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
