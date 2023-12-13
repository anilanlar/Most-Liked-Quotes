import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:most_liked_quotes/Utils/GlobalVariables.dart';
import 'package:most_liked_quotes/View/DetailScreen.dart';

import '../Utils/Enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              String quote = dataList[index]["quote"]!;
              String author = dataList[index]["author"]!;
              String likes = dataList[index]["likes"]!.toString();
              String dislikes = dataList[index]["dislikes"]!.toString();
              List<Map<String, dynamic>> votes = dataList[index]["votes"]!;
              return Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: ListTile(
                      leading: Icon(Icons.star),
                      title: Text(
                        author,
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(quote),
                      onTap: () {
                        print('Star ListTile tapped!');
// Navigator.pushNamed(context, '/home');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen.fromArgs(
                                    quote, author, votes,likes,dislikes)));
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
                                  color: Colors.green, fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dislikes.toString(),
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(width: 12),
                        Column(children: [
                          ElevatedButton(
                              onPressed: () {
                                likeQuote();
                              },
                              child: Center(
                                  child: const Icon(Icons.arrow_upward_sharp))),
                          ElevatedButton(
                              onPressed: () {
                                dislikeQuote();
                              },
                              child: const Icon(Icons.arrow_downward_sharp))
                        ],),

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
