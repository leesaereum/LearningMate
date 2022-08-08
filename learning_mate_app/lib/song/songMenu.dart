import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_mate_app/diamond/diamondPdf.dart';
import 'package:learning_mate_app/song/songPdf.dart';
import 'package:learning_mate_app/song/songPredict.dart';
import 'package:path_provider/path_provider.dart';
import 'package:learning_mate_app/diamond/diamondPredict.dart';



class SongMenu extends StatefulWidget {
  const SongMenu({Key? key}) : super(key: key);

  @override
  State<SongMenu> createState() => _SongMenuState();
}

class _SongMenuState extends State<SongMenu> {
  String pathPDF = "";

    @override
  void initState() {
    super.initState();
        fromAsset('assets/asdf.pdf', 'asdf.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
  }

    Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = "http://www.pdf995.com/samples/pdf.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset("images/MainLogo2.png", width: 200),
          backgroundColor: const Color.fromRGBO(250, 250, 250, 2),
          elevation: 0.8,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.grey,
              )),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                minimumSize: const Size(300, 50)
              ),
                onPressed: () {
                    if (pathPDF.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongPdf(path: pathPDF),
                        ),
                      );
                    }
                },
                child: const Text("노래 분석 과정")
                ),
                const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                minimumSize: const Size(300, 50)
              ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SongPredict(),
                      ));
                },
                child: const Text("노래 예측 확인")
                ),
          ],
        ),
      ),
    );
  }
}
