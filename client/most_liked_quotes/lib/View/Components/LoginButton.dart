import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function onTap;
  const LoginButton({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Navigate to the second screen when the button is pressed
        await onTap();
        //Navigator.pushNamed(context, '/home');
      },
      child: Text('Login'),
    );
  }
}
