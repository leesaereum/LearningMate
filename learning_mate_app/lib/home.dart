import 'package:flutter/material.dart';
import 'package:learning_mate_app/learning/ml.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: const Color.fromRGBO(255, 128, 0, 10),
                minimumSize: const Size(270, 70),
                side: const BorderSide(color: Colors.black26, width: 1),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ml()));
              },
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Machine Learning',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 30),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: const Color.fromRGBO(255, 128, 0, 10),
                minimumSize: const Size(270, 70),
                side: const BorderSide(color: Colors.black26, width: 1),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ml()));
              },
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Deep Learning',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
