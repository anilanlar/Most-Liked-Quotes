import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:most_liked_quotes/View/Components/CustomTextField.dart';
import 'package:most_liked_quotes/View/Components/LoginButton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(),
          Container(
            child: Column(
              children: [
                SizedBox(
                  width: 350,
                  child: CustomTextField(
                    isObscure: false,
                    labelText: "Username",
                    hintText: "ABC",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 350,
                  child: CustomTextField(
                    isObscure: true,
                    labelText: "Password",
                    hintText: "ABC",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                LoginButton()
              ],
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
