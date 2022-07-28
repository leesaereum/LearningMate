import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learningmateapp/Login.dart';
import 'package:learningmateapp/home.dart';
import 'package:learningmateapp/static.dart';

// void main() {
//   runApp(const MyApp());
// }

Future main() async {
  //firebase google login
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// @override
// void initState() {
//   initializeFlutterFire();
//   super.initState();
// }

// //파이어베이스 초기화 함수
// void initializeFlutterFire() async {
//   try {
//     // Wait for Firebase to initialize and set `_initialized` state to true
//     await Firebase.initializeApp();
//     setState(() {
//       _initialized = true;
//       //    loadFirebase();
//     });
//   } catch (e) {
//     // Set `_error` stat7e to true if Firebase initialization fails
//     setState(() {
//       _error = true;
//     });
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Static.id.isEmpty ? const LoginMain() : const Home());
  }
}
