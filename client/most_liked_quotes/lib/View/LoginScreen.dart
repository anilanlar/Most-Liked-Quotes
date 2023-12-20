import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:most_liked_quotes/Provider/auth.dart';
import 'package:most_liked_quotes/View/Components/CustomTextField.dart';
import 'package:most_liked_quotes/View/Components/LoginButton.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool error = false;
  String errorMessage = "";

  Future<bool> login() async {
    final auth = Provider.of<Auth>(context, listen: false);
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      error = true;
      errorMessage = "All fields are mandatory!";
      return false;
    }
    try {
      setState(() {
        error = false;
        errorMessage = "";
      });
      await auth.login(usernameController.text, passwordController.text).then((
          value) =>
      {
        if (auth.id != "-1")
          {
            setState(() {
              error = false;
              errorMessage = "";
            })
          }
        else
          {
            setState(() {
              error = true;
              errorMessage = "Invalid Credentials";
            })
          }
      });
    } catch (e) {
      setState(() {
        error = true;
        errorMessage = "Something went wrong.";
      });
    }
    return error ? false : true;
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Image.asset(
                        "assets/logo.png", width: 250, height: 250),
                    ),
                const SizedBox(
                  width: 350,
                  child: Text(
                    "Log In",
                    style: TextStyle(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 350,
                  child: CustomTextField(
                    isObscure: false,
                    labelText: "Username",
                    hintText: "Username",
                    controller: usernameController,
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
                    hintText: "password",
                    controller: passwordController,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                LoginButton(
                  onTap: () async {
                    if (await login() && mounted) {
                      Navigator.pushNamed(context, '/home');
                    }
                  },
                ),
                Text(error ? errorMessage : ""),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
