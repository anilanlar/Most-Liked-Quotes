import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:most_liked_quotes/Provider/auth.dart';
import 'package:most_liked_quotes/View/Components/CustomTextField.dart';
import 'package:most_liked_quotes/View/Components/LoginButton.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool error = false;
  String errorMessage = "";

  Future<bool> signup() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        error = true;
      errorMessage = "All fields are mandatory!";
      });
      
      return false;
    }
    try {
      final auth = Provider.of<Auth>(context, listen: false);

      await auth.signup(usernameController.text, passwordController.text);

      if (auth.id != "-1") {
        setState(() {
          error = false;
          errorMessage = "";
        });
      } else {
        setState(() {
          error = true;
          errorMessage = auth.error;
        });
      }
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
                const SizedBox(
                  width: 350,
                  child: Text(
                    "Sign Up",
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
                ElevatedButton(
                  onPressed: () async {
                    if (await signup() && mounted) {
                      Navigator.pushNamed(context, '/home');
                    }
                  },
                  child: Text("Sign Up"),
                ),
                Text(error ? errorMessage : ""),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text(
                      "Already have an account?",
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
