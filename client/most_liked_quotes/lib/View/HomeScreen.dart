import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:most_liked_quotes/Models/quote.dart';
import 'package:most_liked_quotes/Provider/quotes.dart';
import 'package:most_liked_quotes/Utils/GlobalVariables.dart';
import 'package:most_liked_quotes/View/DetailScreen.dart';
import 'package:provider/provider.dart';

import '../Utils/Enums.dart';

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

  void likeQuote() async {}

  void dislikeQuote() async {}

  final List<Map<String, dynamic>> dataList = [
    {
      'author': 'Heroes',
      'quote':
          'Not all heroes wear Not all heroes wear capes sdkfjksadfj aksdf jasd fjasdf jkdasfj kasdjfk asdjk asdjfk asdjkfNot all heroes wear capes sdkfjksadfj aksdf jasd fjasdf jkdasfj kasdjfk asdjk asdjfk asdjkfNot all heroes wear capes sdkfjksadfj aksdf jasd fjasdf jkdasfj kasdjfk asdjk asdjfk asdjkfcapes sdkfjksadfj aksdf jasd fjasdf jkdasfj kasdjfk asdjk asdjfk asdjkf asjfk aj.',
      "likes": 32,
      "dislikes": 21,
      "votes": [
        {"voter": "anil", "vote": Vote.LIKE},
        {"voter": "anil", "vote": Vote.LIKE},
        {"voter": "anil", "vote": Vote.LIKE},
        {"voter": "anil", "vote": Vote.DISLIKE}
      ]
    },
    // {
    //   'author': 'Heroes',
    //   'quote': 'Not all heroes wear capes.',
    //   "likes": 32,
    //   "dislikes": 21
    // },

    // {'title': 'Opportunities', 'subtitle': 'Opportunities don\'t happen, you create them.',"numberOfLikes":47}

    // Add more data as needed
  ];

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
              List<Map<String, dynamic>> votes = [
        {"voter": "anil", "vote": Vote.LIKE},
        {"voter": "anil", "vote": Vote.LIKE},
        {"voter": "anil", "vote": Vote.LIKE},
        {"voter": "anil", "vote": Vote.DISLIKE}
      ];
              return Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: ListTile(
                      leading: Icon(Icons.star),
                      title: Text(
                        "",//author,
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(quote),
                      onTap: () {
                        print('Star ListTile tapped!');
// Navigator.pushNamed(context, '/home');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen.fromArgs(quote, " ", votes, likes, dislikes)));
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
                        SizedBox(width: 12),
                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  likeQuote();
                                },
                                child: Center(child: const Icon(Icons.arrow_upward_sharp))),
                            ElevatedButton(
                                onPressed: () {
                                  dislikeQuote();
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
