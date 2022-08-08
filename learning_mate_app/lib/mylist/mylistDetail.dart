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
  List mylistCarat = [];
  List mylistCut = [];
  List mylistClarity = [];
  List mylistColor = [];
  List mylistDepth = [];
  List mylistTable = [];
  List mylistX = [];
  List mylistY = [];
  List mylistZ = [];
  List mylistResult = [];
  List mylistTitle = [];
  List mylistLyric = [];
  List cutlist = ["Fair", "Good", "Very Good", "Premium", "Ideal"];
  List colorlist = ["J", "I", "H", "G", "F", "E", "D"];
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(width: 300,height: 300,
                          child: Text(
                            '가사 : ${mylistLyric[widget.list_num]}',
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
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
                                'cut : ',
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
                                'color : ',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'depth : ',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'table : ',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'x : ',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'y : ',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'z : ',
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
                                '${cutlist[double.parse(mylistCut[widget.list_num]).toInt()]}',
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
                                '${colorlist[double.parse(mylistColor[widget.list_num]).toInt()]}',
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${mylistDepth[widget.list_num]}',
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${mylistTable[widget.list_num]}',
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${mylistX[widget.list_num]}',
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
                              Text(
                                '${mylistZ[widget.list_num]}',
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
                        'result : ${double.parse(mylistResult[widget.list_num]).round()}',
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
          mylistCut.addAll([element['cut']]);
          mylistClarity.addAll([element['clarity']]);
          mylistColor.addAll([element['color']]);
          mylistDepth.addAll([element['depth']]);
          mylistTable.addAll([element['table']]);
          mylistX.addAll([element['x']]);
          mylistY.addAll([element['y']]);
          mylistZ.addAll([element['z']]);
          mylistResult.addAll([element['result']]);
          mylistTitle.addAll([element['title']]);
          mylistLyric.addAll([element['lyric']]);
        });
      });
    });
  }
}
