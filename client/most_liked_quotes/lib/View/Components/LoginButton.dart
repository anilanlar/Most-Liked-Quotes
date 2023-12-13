import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to the second screen when the button is pressed
        Navigator.pushNamed(context, '/home');
      },
      child: Text('Login'),
    );
  }
}