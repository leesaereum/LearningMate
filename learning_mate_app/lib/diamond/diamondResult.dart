import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:learning_mate_app/diamond/diamond_model.dart';
import 'package:learning_mate_app/login/join_model.dart';
import 'package:learning_mate_app/static.dart';
import 'package:intl/intl.dart' show DateFormat;

class DiamondResult extends StatefulWidget {
  final double carat;
  final double cut;
  final double color;
  final double clarity;
  final double depth;
  final double table;
  final double x;
  final double y;
  final double z;

  const DiamondResult({
    Key? key,
    required this.carat,
    required this.cut,
    required this.color,
    required this.clarity,
    required this.depth,
    required this.table,
    required this.x,
    required this.y,
    required this.z,
  }) : super(key: key);

  @override
  State<DiamondResult> createState() => _DiamondResultState();
}

class _DiamondResultState extends State<DiamondResult> {
  List cutlist = ["Fair", "Good", "Very Good", "Premium", "Ideal"];
  List colorlist = ["J", "I", "H", "G", "F", "E", "D"];
  List claritylist = ["I1", "SI2", "SI1", "VS2", "VS1", "VVS2", "VVS1", "IF"];
  String result = "0";
  TextEditingController title = TextEditingController();

  @override
  void initState() {
    super.initState();
    getJSONData();
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                '다이아몬드 예측 결과',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 77, 3, 10),
                ),
              ),
              const SizedBox(
                height: 40,
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
                        '${widget.carat}',
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${cutlist[widget.cut.toInt()]}',
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${claritylist[widget.clarity.toInt()]}',
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${colorlist[widget.color.toInt()]}',
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.depth}',
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.table}',
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.x}',
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.y}',
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.z}',
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
                height: 40,
              ),
              Text(
                '결과 : ${double.parse(result).round()}',
                style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () {
                    _showDialog(context);
                  },
                  child: Text("저장하기")),
              ElevatedButton(onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }, 
              child: Text("돌아가기")),
            ],
          ),
        ),
      ),
    );
  }

  void getJSONData() async {
    var url = Uri.parse(
        'http://localhost:5000/diamond?carat=${widget.carat}&cut=${widget.cut+1}&color=${widget.color+1}&clarity=${widget.clarity+1}&depth=${widget.depth}&table=${widget.table}&x=${widget.x}&y=${widget.y}&z=${widget.z}');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      print(dataConvertedJSON);
      result = dataConvertedJSON['result'].toString();
      print(result);
    });
  }

  // mylist에 저장하는 함수
  mylistInsert() {
    try {
      DiamondModel diamondModel = DiamondModel(
        title: title.text,
        carat: widget.carat.toString(),
        cut: widget.cut.toString(),
        color: widget.color.toString(),
        clarity: widget.clarity.toString(),
        depth: widget.depth.toString(),
        table: widget.table.toString(),
        x: widget.x.toString(),
        y: widget.y.toString(),
        z: widget.z.toString(),
        lyric: "",
        result: result,
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore
          .collection('mylist/${Static.id}/mylist')
          .add(diamondModel.toMap());
    } catch (ex) {
      log('error)', error: ex.toString(), stackTrace: StackTrace.current);
    }
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('리스트 추가하기'),
            actions: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: title,
                      decoration: InputDecoration(
                        labelText: '리스트 이름을 입력하세요.',
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
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (title.text.trim().isEmpty) {
                            titleSnackBar(context);
                          } else {
                            mylistInsert();
                            mylistaddSnackBar(context);
                            Navigator.of(ctx).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 10),
                            primary: const Color.fromARGB(255, 4, 31, 56)),
                        child: const Text('추가'),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 10),
                            primary: const Color.fromARGB(255, 4, 31, 56)),
                        child: const Text('취소'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }

  titleSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('리스트 이름을 입력해주세요.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  mylistaddSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('리스트가 추가되었습니다.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }
}
