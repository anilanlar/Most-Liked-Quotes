import 'package:flutter/material.dart';
import 'package:most_liked_quotes/Models/quote.dart';
import 'package:most_liked_quotes/Models/vote.dart';
import 'package:most_liked_quotes/Provider/quotes.dart';
import 'package:provider/provider.dart';

import '../Utils/Enums.dart';
import '../Utils/GlobalVariables.dart';

class DetailScreen extends StatefulWidget {
  final Quote? quote;

  const DetailScreen({super.key, this.quote,});
  const DetailScreen.fromArgs( this.quote, {super.key});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

   List<Vote> votes = [];
  bool isLoading = false;
  bool error = false;
  String errorMessage = "";

  bool _isFirstTime = true;

  void getAllVotes() async {
    final quotesProvider = Provider.of<QuotesProvider>(context);
    try {
      setState(() {
        error = false;
        errorMessage = "";
        isLoading = true;
      });
      await quotesProvider.getVotes(widget.quote!.id.toString());

      setState(() {
        isLoading = false;
        votes = quotesProvider.allVotes;
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
      getAllVotes();
      _isFirstTime = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.appBarColor,
        title: Text(GlobalVariables.appTitle),
        centerTitle: true,
      ),
      body: Center(
        child: isLoading?  Container(
              padding: const EdgeInsets.only(top: 32),
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ) :Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
              child: Text(
                widget.quote!.content,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.quote!.upVotes.toString(),
                  style: const TextStyle(
                      color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  widget.quote!.downVotes.toString(),
                  style:
                      const TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: votes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(
                          votes[index].type == VoteType.LIKE ? Icons.thumb_up : Icons.thumb_down),
                      title: Text(
                        votes[index].username,
                        style: const TextStyle(color: Colors.black),
                      ),
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
