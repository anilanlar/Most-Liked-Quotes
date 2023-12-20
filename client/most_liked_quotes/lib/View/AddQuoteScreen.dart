
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/auth.dart';
import '../Provider/quotes.dart';
import '../Utils/GlobalVariables.dart';

class AddQuoteScreen extends StatefulWidget {
  const AddQuoteScreen({super.key});

  @override
  State<AddQuoteScreen> createState() => _AddQuoteScreenState();
}

class _AddQuoteScreenState extends State<AddQuoteScreen> {

  void addQuote(String quote) async {
    final quotesProvider = Provider.of<QuotesProvider>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    try {
      await quotesProvider.addQuote(quote, auth.id);
      await quotesProvider.getQuotes(auth.id);

    } catch (e) {
        print("Error adding a quote!");
    }
  }

  String? quote;
  bool error = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: GlobalVariables.appBarColor,
      title: Text(GlobalVariables.appTitle),
      centerTitle: true,
    ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (val) {
                quote = val;
              },
              decoration: const InputDecoration(
                labelText: 'Add Your Quote',
                border: OutlineInputBorder(),
              ),

            ),

          ),
          SizedBox(height: 16), // Add some spacing between TextField and Button
          Text(error ? errorMessage : ""),

          ElevatedButton(
            onPressed: () {
              if(quote != null && quote!=""){
                addQuote(quote!);
                Navigator.pop(context);
              }else{
                setState(() {
                  errorMessage = "Enter a valid quote";
                  error = true;
                });
              }
            },

            child: Text('Submit'),
          ),

        ],
      ),
    );
  }
}
