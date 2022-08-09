import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class openImage extends StatefulWidget {
  final String images;
  const openImage({Key? key, required this.images}) : super(key: key);

  @override
  State<openImage> createState() => _openImageState();
}

class _openImageState extends State<openImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.white, elevation: 0, actions: []),
      body: Center(
        child: Container(
          color: Colors.black,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //const SizedBox()
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
              ],
            ),
            Image.network(
              widget.images,
              width: 300,
            ),
          ]),
        ),
      ),
    );
  }
}
