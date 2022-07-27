import 'package:flutter/material.dart';
import 'package:learning_mate_app/home.dart';
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
        appBar: AppBar(
          title: const Text('LEARNING MATE'),
          backgroundColor: const Color.fromRGBO(255, 128, 0, 10),
        ),
        body: Static.id.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Learning Mate',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          //ff7f00
                          primary: const Color.fromRGBO(255, 128, 0, 10)),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '로그인 하러 가기',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      '러닝메이트가 처음이신가요?',
                      style: TextStyle(color: Colors.black54),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          '회원가입 하러 가기',
                          style:
                              TextStyle(color: Color.fromARGB(255, 0, 77, 3)),
                        ))
                  ],
                ),
              )
            : const Center(
                child: Home(),
              ));
  }
}
