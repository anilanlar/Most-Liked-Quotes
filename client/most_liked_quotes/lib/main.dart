
import 'package:flutter/material.dart';
import 'package:most_liked_quotes/Provider/auth.dart';
import 'package:most_liked_quotes/Provider/quotes.dart';
import 'package:most_liked_quotes/View/DetailScreen.dart';


import 'package:most_liked_quotes/View/HomeScreen.dart';
import 'package:most_liked_quotes/View/LoginScreen.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:most_liked_quotes/View/SignupScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (context) => Auth()),
        ChangeNotifierProvider<QuotesProvider>(create: (context) => QuotesProvider()),
      ],
      child: Portal(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MostLikedQuotes',
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
            '/detail': (context) => DetailScreen(),
            '/signup': (context) => SignUpScreen(),
          },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // home: const MyHomePage(title: 'Most Liked Quotes'),
        ),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   void connectToServer() async {
//     const String serverAddress = 'localhost';
//     const int serverPort = 8080;
//
//     try {
//       Socket socket = await Socket.connect(serverAddress, serverPort);
//       debugPrint("CONNECTED");
//
//       // Add your logic for sending/receiving data or any other actions here
//
//       // Example: Send a message to the server
//       String message = 'Hello, server!';
//       socket.write(message);
//
//       // Example: Read the server's response
//       socket.listen(
//             (List<int> data) {
//           String response = String.fromCharCodes(data);
//           print('Server response: $response');
//         },
//         onDone: () {
//           print('Connection closed by server.');
//           socket.destroy();
//         },
//         onError: (error) {
//           print('Error: $error');
//           socket.destroy();
//         },
//       );
//     } catch (e) {
//       print('Error connecting to the server:>>>> $e');
//       // Handle the error appropriately
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//      return
//   }
// }



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
