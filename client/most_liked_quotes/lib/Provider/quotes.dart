import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:most_liked_quotes/Models/quote.dart';

class QuotesProvider with ChangeNotifier {
  static const String serverAddress = '192.168.1.246';
  static const int serverPort = 8080;

  List<Quote> allQuotes = [];

  String error = "";

  Future<void> getQuotes() async {
    Completer<void> completer = Completer<void>();
    try {
      Socket socket = await Socket.connect(serverAddress, serverPort);
      // Add your logic for sending/receiving data or any other actions here
      print("connected");
      String response = "";
      // Example: Send a message to the server
      String requestType = 'get_quotes';
      socket.writeln(requestType);
      // Example: Read the server's response
      socket.listen(
        (data) {
          response = response + utf8.decode(data);
          print(response);
        },
        onDone: () {
          debugPrint('Connection closed by server.');
          allQuotes = [];
          List<String> params = response.split("\n");
          if (params[params.length-1].contains("StatusCode: 200")) {
            for (int i = 0; i < params.length - 1; i++) {
              allQuotes.add(Quote.fromLine(params[i]));
            }
            error = "";
          } else {
            error = params[params.length-1];
          }
          socket.destroy();
          notifyListeners();
          completer.complete();
        },
        onError: (error) {
          debugPrint('Error: $error');
          socket.destroy();
          notifyListeners();
          completer.completeError(error);
        },
      );
    } catch (e) {
      print('Error connecting to the server:>>>> $e');
      completer.completeError(e);

      // Handle the error appropriately
    }
    return completer.future;
  }

}
