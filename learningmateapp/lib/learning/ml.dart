import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ml extends StatefulWidget {
  const ml({Key? key}) : super(key: key);

  @override
  State<ml> createState() => _mlState();
}

class _mlState extends State<ml> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Machine Learing'),
            const Text('Machine Learing'),
          ],
        ),
      ),
    );
  }
}
