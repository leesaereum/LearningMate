import 'package:flutter/material.dart';
import 'package:learning_mate_app/static.dart';

void main() {
  runApp(const MyApp());
}

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
    return Scaffold(
      appBar: AppBar(title: const Text('LEARNING MATE')),
      body: Static.id.isEmpty
          ? Center(
              child: Column(
                children: [
                  Text('Learning Mate'),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('로그인 하러 가기'))
                ],
              ),
            )
          : Center(
              child: Column(
                children: [Text('로그인 됨쓰')],
              ),
            ),
    );
  }
}
