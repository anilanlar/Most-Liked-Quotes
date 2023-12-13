import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MostLikedQuotes',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Most Liked Quotes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void connectToServer() async {
    const String serverAddress = 'localhost';
    const int serverPort = 8080;

    try {
      Socket socket = await Socket.connect(serverAddress, serverPort);
      debugPrint("CONNECTED");

      // Add your logic for sending/receiving data or any other actions here

      // Example: Send a message to the server
      String message = 'Hello, server!';
      socket.write(message);

      // Example: Read the server's response
      socket.listen(
            (List<int> data) {
          String response = String.fromCharCodes(data);
          print('Server response: $response');
        },
        onDone: () {
          print('Connection closed by server.');
          socket.destroy();
        },
        onError: (error) {
          print('Error: $error');
          socket.destroy();
        },
      );
    } catch (e) {
      print('Error connecting to the server:>>>> $e');
      // Handle the error appropriately
    }
  }

  void likeQuote() async{}
  void dislikeQuote() async{}

  final List<Map<String, dynamic>> dataList = [
    {'title': 'Heroes', 'subtitle': 'Not all heroes wear capes.',"numberOfLikes": 32},
    {'title': 'Opportunities', 'subtitle': 'Opportunities don\'t happen, you create them.',"numberOfLikes":47},
    {'title': 'Heroes', 'subtitle': 'Not all heroes wear capes.',"numberOfLikes": 32},
    {'title': 'Opportunities', 'subtitle': 'Opportunities don\'t happen, you create them.',"numberOfLikes":47},
    {'title': 'Heroes', 'subtitle': 'Not all heroes wear capes.',"numberOfLikes": 32},
    {'title': 'Opportunities', 'subtitle': 'Opportunities don\'t happen, you create them.',"numberOfLikes":47},
    {'title': 'Heroes', 'subtitle': 'Not all heroes wear capes.',"numberOfLikes": 32},
    {'title': 'Opportunities', 'subtitle': 'Opportunities don\'t happen, you create them.',"numberOfLikes":47},
    {'title': 'Heroes', 'subtitle': 'Not all heroes wear capes.',"numberOfLikes": 32},
    {'title': 'Opportunities', 'subtitle': 'Opportunities don\'t happen, you create them.',"numberOfLikes":47},
    {'title': 'Heroes', 'subtitle': 'Not all heroes wear capes.',"numberOfLikes": 32},
    {'title': 'Opportunities', 'subtitle': 'Opportunities don\'t happen, you create them.',"numberOfLikes":47},
    {'title': 'Heroes', 'subtitle': 'Not all heroes wear capes.',"numberOfLikes": 32},
    {'title': 'Opportunities', 'subtitle': 'Opportunities don\'t happen, you create them.',"numberOfLikes":47},
    {'title': 'Heroes', 'subtitle': 'Not all heroes wear capes.',"numberOfLikes": 32},
    {'title': 'Opportunities', 'subtitle': 'Opportunities don\'t happen, you create them.',"numberOfLikes":47},

    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
         title: Text(widget.title),
      ),
      body:  Container(
        child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                leading: Icon(Icons.star),
                title: Text(
                  dataList[index]["title"]!,
                  style: TextStyle(
                      color: Colors.black
                  ),),
                subtitle: Text(dataList[index]["subtitle"]!),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      dataList[index]["numberOfLikes"].toString(),
                      style: TextStyle(
                          color: Colors.black,
                        fontSize: 20
                      ),),
                    SizedBox(width: 12),
                    ElevatedButton(onPressed: (){likeQuote();}, child: const Icon(Icons.arrow_upward_sharp)),
                    ElevatedButton(onPressed: (){dislikeQuote();}, child: const Icon(Icons.arrow_downward_sharp))
                  ],
                ),
                onTap: () {
                  print('Star ListTile tapped!');
                },
              );

            }),
      ),
     );
  }
}



//
// body: Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// ElevatedButton(onPressed: (){
// connectToServer();
// }, child: Text("CONNECT")),
// // ListTile(
// //   leading: Icon(Icons.star),
// //   title: const Text('Star',
// //   style: TextStyle(
// //     color: Colors.black
// //   ),),
// //   subtitle: Text('This is a starThis is a starThis is a starThis is a starThis is a starThis is a star.'),
// //   trailing: Row(
// //     mainAxisAlignment: MainAxisAlignment.end,
// //     mainAxisSize: MainAxisSize.min,
// //     children: [
// //       ElevatedButton(onPressed: (){}, child: const Icon(Icons.arrow_upward_sharp)),
// //       ElevatedButton(onPressed: (){}, child: const Icon(Icons.arrow_downward_sharp))
// //     ],
// //   ),
// //   onTap: () {
// //     print('Star ListTile tapped!');
// //   },
// // ),
// ListView.builder(
// itemCount: dataList.length,
// itemBuilder: (BuildContext context, int index){
// return ListTile(
// leading: Icon(Icons.star),
// title: Text(
// dataList[index]["title"]!,
// style: TextStyle(
// color: Colors.black
// ),),
// subtitle: Text(dataList[index]["subtitle"]!),
// trailing: Row(
// mainAxisAlignment: MainAxisAlignment.end,
// mainAxisSize: MainAxisSize.min,
// children: [
// ElevatedButton(onPressed: (){}, child: const Icon(Icons.arrow_upward_sharp)),
// ElevatedButton(onPressed: (){}, child: const Icon(Icons.arrow_downward_sharp))
// ],
// ),
// onTap: () {
// print('Star ListTile tapped!');
// },
// );
//
// }),
//
// ],
// ),
// ),
