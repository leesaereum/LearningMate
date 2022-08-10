import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learning_mate_app/diamond/diamondResult.dart';
import 'package:learning_mate_app/song/songResult.dart';

class SongPredict extends StatefulWidget {
  const SongPredict({Key? key}) : super(key: key);

  @override
  State<SongPredict> createState() => _SongPredictState();
}

class _SongPredictState extends State<SongPredict> {
  TextEditingController lyric = TextEditingController();

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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
              const SizedBox(height: 50,),
                                const Text(
                "노래 가사 입력하기",
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 77, 3, 10),
                ),
                
              ),
              const SizedBox(height: 50,),
                const Text(
                "가사를 입력하세요.",
                style: TextStyle(fontSize: 24,
                color: Color.fromRGBO(0, 77, 3, 10),),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: lyric,
                  minLines: 10,
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: '가사',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 4, 31, 56)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(255, 128, 0, 10),
                     minimumSize: const Size(150, 40),
                      maximumSize: const Size(150, 40)),
                    onPressed: () {
                      if (lyric.text.trim().isEmpty) {
                        nullSnackBar(context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SongResult(lyric: lyric.text),
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.search),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "예측하기",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  nullSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('빈칸을 전부 입력해 주세요.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  pointSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('숫자를 제대로 입력해 주세요.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }
}
