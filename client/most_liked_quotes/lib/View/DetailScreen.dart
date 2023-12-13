import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/Enums.dart';
import '../Utils/GlobalVariables.dart';

class DetailScreen extends StatelessWidget {

  String? quote;
  String? author;
  List<Map<String,dynamic>>? votes;
  String? likes;
  String? dislikes;
   DetailScreen();
   DetailScreen.fromArgs(this.quote, this.author, this.votes, this.likes, this.dislikes ,{super.key});


  @override
  Widget build(BuildContext context) {
    // List<Map<String,dynamic>> votes = [
    //   {"voter": "anil", "vote":Vote.LIKE },
    //   {"voter": "anil", "vote":Vote.LIKE },
    //   {"voter": "anil", "vote":Vote.LIKE },
    //   {"voter": "anil", "vote":Vote.DISLIKE }


    // ];
    return Scaffold(
        appBar: AppBar(
        backgroundColor: GlobalVariables.appBarColor,
    title: Text(GlobalVariables.appTitle),
    centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
             Padding(
               padding: const EdgeInsets.fromLTRB(40,20,40,10),
               child: Text(
                quote!,
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
            ),
          ),
             ),
             Text(
              author!,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.grey,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
              likes!,
              style: const TextStyle(
                  color: Colors.green, fontSize: 20,fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 20,),
            Text(
              dislikes!,
              style: const TextStyle(
                  color: Colors.red, fontSize: 20,fontWeight: FontWeight.bold),
            ),
          ],),
          Expanded(
            child: ListView.builder(
                itemCount: votes!.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    leading: Icon(votes![index]["vote"] == Vote.LIKE ? Icons.thumb_up : Icons.thumb_down),
                    title: Text(
                      votes![index]["voter"]!,
                      style: TextStyle(
                          color: Colors.black
                      ),),
                    onTap: () {
                      print('Star ListTile tapped!');
                    },
                  );

                }),
          )

          ],

        ),
      ),
    );
  }
}
