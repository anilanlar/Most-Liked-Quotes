import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:most_liked_quotes/Models/quote.dart';
import 'package:most_liked_quotes/Provider/auth.dart';
import 'package:most_liked_quotes/Provider/quotes.dart';
import 'package:most_liked_quotes/Utils/GlobalVariables.dart';
import 'package:most_liked_quotes/View/DetailScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Quote> allQuotes = [];
  bool isLoading = false;
  bool error = false;
  String errorMessage = "";

  bool _isFirstTime = true;


  void getAllQuotes() async {
    final quotesProvider = Provider.of<QuotesProvider>(context);
    try {
      setState(() {
        error = false;
        errorMessage = "";
        isLoading = true;
      });
      await quotesProvider.getQuotes();

      setState(() {
        isLoading = false;
        allQuotes = quotesProvider.allQuotes;
      });
    } catch (e) {
      setState(() {
        error = true;
        errorMessage = "Something went wrong.";
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (_isFirstTime) {
      getAllQuotes();
      _isFirstTime = false;
    }
    super.didChangeDependencies();
  }

  void likeQuote(String quoteId) async {

    final quotesProvider = Provider.of<QuotesProvider>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    try {
      setState(() {
        error = false;
        errorMessage = "";
        isLoading = true;
      });
      await quotesProvider.upVote(quoteId, auth.id);
      await quotesProvider.getQuotes();

      setState(() {
        isLoading = false;
        allQuotes = quotesProvider.allQuotes;
      });
    } catch (e) {
      setState(() {
        error = true;
        errorMessage = "Something went wrong.";
      });
    }
  }

  void dislikeQuote(String quoteId) async {

    
    final quotesProvider = Provider.of<QuotesProvider>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    try {
      setState(() {
        error = false;
        errorMessage = "";
        isLoading = true;
      });
      await quotesProvider.downVote(quoteId, auth.id);
      await quotesProvider.getQuotes();

      setState(() {
        isLoading = false;
        allQuotes = quotesProvider.allQuotes;
      });
    } catch (e) {
      setState(() {
        error = true;
        errorMessage = "Something went wrong.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.appBarColor,
        title: Text(GlobalVariables.appTitle),
        centerTitle: true,
      ),
      body: Container(
        child: isLoading?  Container(
              padding: const EdgeInsets.only(top: 32),
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ) :ListView.builder(
            itemCount: allQuotes.length,
            itemBuilder: (BuildContext context, int index) {
              String quote = allQuotes[index].content;
              //String author = dataList[index]["author"]!;
              String likes = allQuotes[index].upVotes.toString();
              String dislikes = allQuotes[index].downVotes.toString();
              return Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: ListTile(
                      leading: Icon(Icons.star),
                      title: const Text(
                        "",//author,
                        style:  TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(quote),
                      onTap: () {
                        print('Star ListTile tapped!');
// Navigator.pushNamed(context, '/home');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen.fromArgs(allQuotes[index])));
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            Text(
                              likes.toString(),
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dislikes.toString(),
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  likeQuote(allQuotes[index].id.toString());
                                },
                                child: const Center(child:  Icon(Icons.arrow_upward_sharp))),
                            ElevatedButton(
                                onPressed: () {
                                  dislikeQuote(allQuotes[index].id.toString());
                                },
                                child: const Icon(Icons.arrow_downward_sharp))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}

// Row(
// children: [
// Expanded(child: Container(
// child: Column(),
// height:100,color: CupertinoColors.activeGreen,), flex: 5,),
// Expanded(child: Container(height:100,color: CupertinoColors.activeBlue,),flex: 2,)
// ],
// );;
