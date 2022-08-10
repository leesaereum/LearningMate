import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learning_mate_app/diamond/diamond_model.dart';
import 'package:learning_mate_app/static.dart';

class MylistDetail extends StatefulWidget {
  final int list_num;
  const MylistDetail({Key? key, required this.list_num}) : super(key: key);

  @override
  State<MylistDetail> createState() => _MylistDetailState();
}

class _MylistDetailState extends State<MylistDetail> {
    TextEditingController lyric = TextEditingController();
  List mylistCarat = [];
  List mylistClarity = [];
  List mylistY = [];
  List mylistResult = [];
  List mylistTitle = [];
  List mylistLyric = [];
  List claritylist = ["I1", "SI2", "SI1", "VS2", "VS1", "VVS2", "VVS1", "IF"];

  @override
  void initState() {
    super.initState();
    mylistcall();
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
        child: mylistResult.isEmpty
            ? const Text("로딩중")
            : mylistCarat[widget.list_num].isEmpty
                ? Column(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      Text(
                        '${mylistTitle[widget.list_num]}',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 77, 3, 10),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      const Text(
                        '가사',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                    controller: lyric,
                    minLines: 10,
                    maxLines: 10,
                    readOnly: true,
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
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'result : ${mylistResult[widget.list_num]}',
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      Text(
                        '${mylistTitle[widget.list_num]}',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 77, 3, 10),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'carat : ',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'clarity : ',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'width : ',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${mylistCarat[widget.list_num]}',
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${claritylist[double.parse(mylistClarity[widget.list_num]).toInt()]}',
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${mylistY[widget.list_num]}',
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'result : \$${double.parse(mylistResult[widget.list_num]).round()}',
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
      ),
    );
  }

  // mylist를 불러오는 함수
  mylistcall() {
    FirebaseFirestore.instance
        .collection('mylist/${Static.id}/mylist')
        .snapshots()
        .listen((data) {
      data.docs.forEach((element) {
        setState(() {
          mylistCarat.addAll([element['carat']]);
          mylistClarity.addAll([element['clarity']]);
          mylistY.addAll([element['y']]);
          mylistResult.addAll([element['result']]);
          mylistTitle.addAll([element['title']]);
          mylistLyric.addAll([element['lyric']]);
        });
      });
          if(mylistCarat[widget.list_num].isEmpty){
            lyric.text=mylistLyric[widget.list_num];
          };
    });
  }
}
