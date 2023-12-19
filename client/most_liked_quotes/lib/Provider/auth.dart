import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  static const String serverAddress = '192.168.1.246';
  static const int serverPort = 8080;

  String id = "-1";
  String username = "";

  String error = "";

  bool get isSignedIn {
    return id != "-1";
  }

  Future<void> login(String username, String password) async {
    Completer<void> completer = Completer<void>();
    try {
      Socket socket = await Socket.connect(serverAddress, serverPort);
      // Add your logic for sending/receiving data or any other actions here
      print("connected");
      String response = "";
      // Example: Send a message to the server
      String requestType = 'log_in';
      socket.writeln(requestType);
      socket.writeln(username);
      socket.writeln(password);
      // Example: Read the server's response
      socket.listen(
        (data) {
          response = response + utf8.decode(data);
          print(response);
        },
        onDone: () {
          debugPrint('Connection closed by server.');
          List<String> params = response.split("\n");
          if (params[1].contains("StatusCode: 200")) {
            id = params[0];
            username = username;
            error = "";
          } else {
            id = "-1";
            username = "";
            error = "Invalid Credentials";
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

  Future<void> signup(String username, String password) async {
    Completer<void> completer = Completer<void>();
    try {
      Socket socket = await Socket.connect(serverAddress, serverPort);
      // Add your logic for sending/receiving data or any other actions here
      print("connected");
      String response = "";
      // Example: Send a message to the server
      String requestType = 'sign_up';
      socket.writeln(requestType);
      socket.writeln(username);
      socket.writeln(password);
      // Example: Read the server's response
      socket.listen(
        (data) {
          response = response + utf8.decode(data);
          print(response);
        },
        onDone: () async {
          debugPrint('Connection closed by server.');
          if (response.contains("StatusCode: 201")) {
            await login(username, password);
            error = "";
          } else {
            id = "-1";
            username = "";
            error = "Username is already given.";
          }
          socket.destroy();
          notifyListeners();
          completer.complete();
        },
        onError: (error) {
          debugPrint('Error: $error');
          error = error;
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

  Future<void> logout() {
    Completer<void> completer = Completer<void>();
    id = "-1";
    username = "";
    notifyListeners();
    return completer.future;
  }
}
