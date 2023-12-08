// Sample code to send requests to Server

import 'dart:convert';
import 'dart:io';

void main() {
  String host = 'localhost'; // Change to the actual host address
  int port = 8080; // Change to the actual port number
  void connectToServer() async {
    Socket socket = await Socket.connect(host, port);
    print('Connected to the server!');
    socket.writeln('get_quotes');
    String message = "";
    await socket.listen(
      (data) {
        message = message + utf8.decode(data);
      },
      onDone: () {
        print('Socket closed');
        socket.destroy(); // Close the socket when the stream is done
      },
    );
  }

  void register() async {
    Socket socket = await Socket.connect(host, port);
    socket.writeln("sign_up");
    socket.writeln("zulal");
    socket.writeln("123123");
    String message = "";
    await socket.listen(
      (data) {
        message = message + utf8.decode(data);
      },
      onDone: () {
        if (message.compareTo("StatusCode: 201") == 0) {
          print("user is created");
        } else {
          print("user is not created");
        }
        print('Socket closed');
        socket.destroy(); // Close the socket when the stream is done
      },
    );
  }

  void upvote_quote() async {
    Socket socket = await Socket.connect(host, port);
    socket.writeln("downvote_quote");
    socket.writeln("4");
    socket.writeln("3");
    String message = "";
    await socket.listen(
      (data) {
        message = message + utf8.decode(data);
      },
      onDone: () {
        if (message.compareTo("StatusCode: 200") == 0) {
          print("voted");
        } else {
          print("not voted");
        }
        print('Socket closed');
        socket.destroy();
      },
    );
  }

  //connectToServer();
  //register();
  upvote_quote();
}
