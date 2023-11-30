// Sample code to send requests to Server

import 'dart:convert';
import 'dart:io';

void main() {
  String host = 'localhost'; // Change to the actual host address
  int port = 8080; // Change to the actual port number

  Socket.connect(host, port).then((socket) {
    print('Connected to the server!');
    socket.writeln('message to server');
    socket.listen((event) {
      String resultString = utf8.decode(event);
      print(resultString);
    });
  }).catchError((error) {
    print('Error connecting to the server: $error');
  });
}
