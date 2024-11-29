import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  //methode to store the user name and user email in shared pref
  static Future<void> storeUserDetails({
    required String username,
    required String email,
    required String password,
    required String confirmpassword,
    required BuildContext context,
  }) async {
    //if the users password and the confirm password are same then the store user name an the email
    try {
      //check weather the user entered password and the confirm password are the same
      if (password != confirmpassword) {
        //Show a message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "password and confirm password are do not match",
            ),
          ),
        );
        return;
      }
      //create and instance from share pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //store the user name and email as key value pairs
      await prefs.setString("username", username);
      await prefs.setString("email", email);
      //show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User Deatils Store Sucssesfully"),
        ),
      );
    } catch (err) {
      err.toString();
    }
  }
}
