import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  String labelText;
  String hintText;
  bool isObscure;
  CustomTextField({super.key,required this.labelText,required this.hintText,required this.isObscure});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {


  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isObscure,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: Icon(Icons.text_fields),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      style: TextStyle(fontSize: 16.0),
      onChanged: (value) {
        // Handle text changes here
      },
    );
  }

}
