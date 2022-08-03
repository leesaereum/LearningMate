import 'package:flutter/material.dart';

class dl extends StatefulWidget {
  const dl({Key? key}) : super(key: key);

  @override
  State<dl> createState() => _dlState();
}

class _dlState extends State<dl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Deep Learing'),
            const Text('Deep Learing'),
          ],
        ),
      ),
    );
  }
}
