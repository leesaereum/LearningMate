import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learning_mate_app/mylist/mylistDetail.dart';
import 'package:learning_mate_app/static.dart';

class Mylist extends StatefulWidget {
  const Mylist({Key? key}) : super(key: key);

  @override
  State<Mylist> createState() => _MylistState();
}

class _MylistState extends State<Mylist> {
  List mylisttitle = [];
  List mylistdate = [];

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
          child: mylisttitle.isEmpty
              ? Column(
                  children: [
                    SizedBox(height: 250),
                    Text(
                      '리스트가 비어있습니다.',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: mylisttitle.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MylistDetail(
                              list_num: index,
                            ),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 0, 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        mylisttitle[index],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      const Text('DATE :',
                                          style: TextStyle(color: Colors.grey)),
                                      Text(mylistdate[index],
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                      SizedBox(width: 120),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        '리스트를 삭제하시겠습니까?'),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              // delete(mylist[
                                                              //         index][
                                                              //     'list_num']);
                                                              // print(index);
                                                            },
                                                            child: const Text(
                                                              '예',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          4,
                                                                          31,
                                                                          56)),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 40),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              '아니오',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          4,
                                                                          31,
                                                                          56)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.highlight_remove,
                                            color: Colors.grey,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
        ));
  }

  // mylist를 불러오는 함수
  mylistcall() {
    FirebaseFirestore.instance
        .collection('mylist/${Static.id}/mylist')
        .snapshots()
        .listen((data) {
      data.docs.forEach((element) {
        setState(() {
          mylisttitle.addAll([element['title']]);
          mylistdate.addAll([element['date']]);
        });
      });
    });
  }
}
