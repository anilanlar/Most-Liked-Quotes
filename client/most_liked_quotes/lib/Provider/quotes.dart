import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:most_liked_quotes/Models/quote.dart';
import 'package:most_liked_quotes/Models/vote.dart';
import 'package:provider/provider.dart';

import '../Utils/GlobalVariables.dart';
import 'auth.dart';

class QuotesProvider with ChangeNotifier {
  static const String serverAddress = GlobalVariables.host;
  static const int serverPort = GlobalVariables.port;

  List<Quote> allQuotes = [];
  List<Vote> allVotes = [];

  String error = "";

  Future<void> getQuotes(String userId) async {
    Completer<void> completer = Completer<void>();
    try {
      Socket socket = await Socket.connect(serverAddress, serverPort);
      // Add your logic for sending/receiving data or any other actions here
      String response = "";
      // Example: Send a message to the server
      String requestType = 'get_quotes';
      socket.writeln(requestType);
      socket.writeln(userId);
      // Example: Read the server's response
      socket.listen(
        (data) {
          response = response + utf8.decode(data);
        },
        onDone: () {
          debugPrint('Connection closed by server.');
          allQuotes = [];
          List<String> params = response.split("\n");
          if (params[params.length - 1].contains("StatusCode: 200")) {
            for (int i = 0; i < params.length - 1; i++) {
              allQuotes.add(Quote.fromLine(params[i]));
            }
            error = "";
          } else {
            error = params[params.length - 1];
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

  Future<void> getVotes(String quoteId) async {
    Completer<void> completer = Completer<void>();
    try {
      Socket socket = await Socket.connect(serverAddress, serverPort);
      // Add your logic for sending/receiving data or any other actions here
      print("connected");
      String response = "";
      // Example: Send a message to the server
      String requestType = 'get_votes_by_quote_id';
      socket.writeln(requestType);
      socket.writeln(quoteId);
      // Example: Read the server's response
      socket.listen(
        (data) {
          response = response + utf8.decode(data);
          print(response);
        },
        onDone: () {
          debugPrint('Connection closed by server.');
          allVotes = [];
          print("hello");
          List<String> params = response.split("\n");
          if (params[params.length - 1].contains("StatusCode: 200")) {
            for (int i = 0; i < params.length - 1; i++) {
              allVotes.add(Vote.fromLine(params[i]));
            }
            error = "";
          } else {
            error = params[params.length - 1];
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

  Future<void> upVote(String quoteId, String userId) async {
    Completer<void> completer = Completer<void>();
    try {
      Socket socket = await Socket.connect(serverAddress, serverPort);
      // Add your logic for sending/receiving data or any other actions here
      print("connected");
      String response = "";
      // Example: Send a message to the server
      String requestType = 'upvote_quote';
      socket.writeln(requestType);
      socket.writeln(quoteId);
      socket.writeln(userId);
      // Example: Read the server's response
      socket.listen(
        (data) {
          response = response + utf8.decode(data);
          print(response);
        },
        onDone: () {
          debugPrint('Connection closed by server.');
          if (response.contains("StatusCode: 200")) {
            error = "";
          } else {
            error = "Something went wrong";
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

   Future<void> downVote(String quoteId, String userId) async {
    Completer<void> completer = Completer<void>();
    try {
      Socket socket = await Socket.connect(serverAddress, serverPort);
      // Add your logic for sending/receiving data or any other actions here
      print("connected");
      String response = "";
      // Example: Send a message to the server
      String requestType = 'downvote_quote';
      socket.writeln(requestType);
      socket.writeln(quoteId);
      socket.writeln(userId);
      // Example: Read the server's response
      socket.listen(
        (data) {
          response = response + utf8.decode(data);
          print(response);
        },
        onDone: () {
          debugPrint('Connection closed by server.');
          if (response.contains("StatusCode: 200")) {
            error = "";
          } else {
            error = "Something went wrong";
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

  Future<void> addQuote(String quote, String userId) async{
    Completer<void> completer = Completer<void>();
    try {
      Socket socket = await Socket.connect(serverAddress, serverPort);
      // Add your logic for sending/receiving data or any other actions here
      print("connected");
      String response = "";
      // Example: Send a message to the server
      String requestType = 'add_quote';
      socket.writeln(requestType);
      socket.writeln(quote);
      socket.writeln(userId);
      // Example: Read the server's response
      socket.listen(
            (data) {
          response = response + utf8.decode(data);
          print(response);
        },
        onDone: () {
          debugPrint('Connection closed by server.');
          if (response.contains("StatusCode: 200")) {
            error = "";
          } else {
            error = "Something went wrong";
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
