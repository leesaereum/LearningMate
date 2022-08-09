import 'dart:developer';
import 'dart:io';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_mate_app/chat/message_model.dart';
import 'package:learning_mate_app/chat/openimage.dart';
import 'package:learning_mate_app/static.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  ScrollController listScrollController = ScrollController();
  TextEditingController textcontroller = TextEditingController();
  File? Imagefile;

  bool viewon = false;

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
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('이미지 보내기'),
                      content: Container(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                getImage_camera();
                              },
                              leading: const Icon(
                                Icons.camera_alt,
                                color: Color.fromRGBO(0, 77, 3, 10),
                              ),
                              title: const Text('CAMERA'),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                getImage_gallery();
                              },
                              leading: const Icon(
                                Icons.collections,
                                color: Color.fromRGBO(0, 77, 3, 10),
                              ),
                              title: const Text('GALLERY'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                //getImage_camera();
              },
              icon: const Icon(
                Icons.add,
                color: Colors.grey,
              )),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: StreamBuilder<List<MessageModel>>(
          stream: streamMessages(), //중계하고 싶은 Stream을 넣는다.
          builder: (context, asyncSnapshot) {
            if (!asyncSnapshot.hasData) {
              //데이터가 없을 경우 로딩위젯을 표시한다.
              return const Center(child: CircularProgressIndicator());
            } else if (asyncSnapshot.hasError) {
              return const Center(
                child: Text('오류가 발생했습니다.'),
              );
            } else {
              List<MessageModel> messages =
                  asyncSnapshot.data!; //비동기 데이터가 존재할 경우 리스트뷰 표시
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 15),
                  Expanded(
                      child: ListView.builder(
                          // 상위 위젯의 크기를 기준으로 잡는게 아닌 자식위젯의 크기를 기준으로 잡음
                          controller: listScrollController,
                          itemCount: messages.length,
                          itemBuilder: (content, index) {
                            return messages[index].image.isNotEmpty
                                ? messages[index].content == 'User'
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 5, 8, 5),
                                                  child: GestureDetector(
                                                    onTap: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              openImage(
                                                                  images: messages[
                                                                          index]
                                                                      .image),
                                                        )),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          border: Border.all(
                                                            width: 8,
                                                            color: const Color
                                                                    .fromRGBO(
                                                                255,
                                                                128,
                                                                0,
                                                                10),
                                                          )),
                                                      //color: const Color.fromRGBO(
                                                      //    255, 128, 0, 10),
                                                      child: Image.network(
                                                        messages[index].image,
                                                        width: 150,
                                                        height: 150,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              index != messages.length - 1
                                                  ? messages[index]
                                                          .content
                                                          .isNotEmpty
                                                      ? const Text(
                                                          '',
                                                          style: TextStyle(
                                                              fontSize: 1),
                                                        )
                                                      : Text(
                                                          messages[index]
                                                              .sendDate
                                                              .toDate()
                                                              .toLocal()
                                                              .toString()
                                                              .substring(5, 16),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                        )
                                                  : Text(
                                                      messages[index]
                                                          .sendDate
                                                          .toDate()
                                                          .toLocal()
                                                          .toString()
                                                          .substring(5, 16),
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        border: Border.all(
                                                          width: 8,
                                                          color: const Color(
                                                              0xFFE8E8EE),
                                                        )),
                                                    child: Image.network(
                                                      messages[index].image,
                                                      width: 150,
                                                      height: 150,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              index != messages.length - 1
                                                  ? messages[index]
                                                          .manager
                                                          .isNotEmpty
                                                      ? Text('')
                                                      : Text(
                                                          messages[index]
                                                              .sendDate
                                                              .toDate()
                                                              .toLocal()
                                                              .toString()
                                                              .substring(5, 16),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                        )
                                                  : Text(
                                                      messages[index]
                                                          .sendDate
                                                          .toDate()
                                                          .toLocal()
                                                          .toString()
                                                          .substring(5, 16),
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      )
                                : index != messages.length - 1
                                    ? messages[index].content.isNotEmpty
                                        ? messages[index + 1].content.isNotEmpty
                                            ? BubbleSpecialThree(
                                                text: messages[index].content,
                                                color: const Color.fromRGBO(
                                                    255, 128, 0, 10),
                                                tail: false,
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    children: [
                                                      BubbleSpecialThree(
                                                          text: messages[index]
                                                              .content,
                                                          color: const Color
                                                                  .fromRGBO(
                                                              255, 128, 0, 10),
                                                          tail: true,
                                                          textStyle: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16)),
                                                      Text(
                                                        messages[index]
                                                            .sendDate
                                                            .toDate()
                                                            .toLocal()
                                                            .toString()
                                                            .substring(5, 16),
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                        : messages[index + 1].manager.isEmpty
                                            ? Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      BubbleSpecialThree(
                                                        text: messages[index]
                                                            .manager,
                                                        color:
                                                            Color(0xFFE8E8EE),
                                                        tail: true,
                                                        isSender: false,
                                                      ),
                                                      Text(
                                                          messages[index]
                                                              .sendDate
                                                              .toDate()
                                                              .toLocal()
                                                              .toString()
                                                              .substring(5, 16),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12))
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : BubbleSpecialThree(
                                                text: messages[index].manager,
                                                color: Color(0xFFE8E8EE),
                                                tail: false,
                                                isSender: false,
                                              )
                                    : messages[index].manager.isNotEmpty
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  BubbleSpecialThree(
                                                    text:
                                                        messages[index].manager,
                                                    color: Color(0xFFE8E8EE),
                                                    tail: true,
                                                    isSender: false,
                                                    // textStyle: TextStyle(
                                                    //     color: Colors.white,
                                                    //     fontSize: 16),
                                                  ),
                                                  Text(
                                                      messages[index]
                                                          .sendDate
                                                          .toDate()
                                                          .toLocal()
                                                          .toString()
                                                          .substring(5, 16),
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                children: [
                                                  BubbleSpecialThree(
                                                      text: messages[index]
                                                          .content,
                                                      color:
                                                          const Color.fromRGBO(
                                                              255, 128, 0, 10),
                                                      tail: true,
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16)),
                                                  Text(
                                                    messages[index]
                                                        .sendDate
                                                        .toDate()
                                                        .toLocal()
                                                        .toString()
                                                        .substring(5, 16),
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                          })),
                  getInputWidget(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget getInputWidget() {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: Colors.black12, offset: Offset(0, -2), blurRadius: 3)
      ], color: Theme.of(context).bottomAppBarColor),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextField(
                controller: textcontroller,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(fontSize: 15),
                  labelText: "내용을 입력하세요.",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(255, 128, 0, 10),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.black26,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            RawMaterialButton(
              onPressed: _onPressedSendButton, //전송버튼을 누를때 동작시킬 메소드
              constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              elevation: 2,
              fillColor: const Color.fromRGBO(255, 128, 0, 10),
              shape: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onPressedSendButton() {
    if (textcontroller.text.isNotEmpty) {
      try {
        //서버로 보낼 데이터를 모델클래스에 담아둔다.
        //여기서 sendDate에 Timestamp.now()가 들어가는데 이는 디바이스의 시간을 나타내므로 나중에는 서버의 시간을 넣는 방법으로 변경하도록 하자.
        MessageModel messageModel = MessageModel(
            content: textcontroller.text, sendDate: Timestamp.now());

        //Firestore 인스턴스 가져오기
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        //원하는 collection 주소에 새로운 document를 Map의 형태로 추가하는 모습.
        firestore
            .collection('chat_message/${Static.id}/message/')
            .add(messageModel.toMap());
        textcontroller.text = '';
        lastdown();
      } catch (ex) {
        log('error)', error: ex.toString(), stackTrace: StackTrace.current);
      }
    }
  }

  Stream<List<MessageModel>> streamMessages() {
    try {
      //찾고자 하는 컬렉션의 스냅샷(Stream)을 가져온다.
      Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance
          .collection('chat_message/' + Static.id + "/message")
          .orderBy('sendDate')
          .snapshots();

      //새낭 스냅샷(Stream)내부의 자료들을 List<MessageModel> 로 변환하기 위해 map을 사용하도록 한다.
      //참고로 List.map()도 List 안의 element들을 원하는 형태로 변환하여 새로운 List로 반환한다
      return snapshots.map((querySnapshot) {
        List<MessageModel> messages =
            []; //querySnapshot을 message로 옮기기 위해 List<MessageModel> 선언
        querySnapshot.docs.forEach((element) {
          //해당 컬렉션에 존재하는 모든 docs를 순회하며 messages 에 데이터를 추가한다.
          messages.add(MessageModel.fromMap(
              id: element.id, map: element.data() as Map<String, dynamic>));
        });
        return messages; //QuerySnapshot에서 List<MessageModel> 로 변경이 됐으니 반환
      }); //Stream<QuerySnapshot> 에서 Stream<List<MessageModel>>로 변경되어 반환됨

    } catch (ex) {
      //오류 발생 처리
      log('error)', error: ex.toString(), stackTrace: StackTrace.current);
      return Stream.error(ex.toString());
    }
  }

  Future getImage_gallery() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        Imagefile = File(pickedFile.path);
      });
      if (Imagefile != null) {
        try {
          FirebaseStorage storage = FirebaseStorage.instance;
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          DocumentReference new_city_ref =
              firestore.collection('chat_message/${Static.id}/message/').doc();
          print(new_city_ref);
          final refimage =
              storage.ref().child('${Static.id}/${new_city_ref.id}.png');
          await refimage.putFile(Imagefile!);
          final url = await refimage.getDownloadURL();
          MessageModel messageModel = MessageModel(
              content: 'User', image: url, sendDate: Timestamp.now());
          new_city_ref.set(messageModel.toMap());
          lastdown();
        } catch (ex) {
          log('error)', error: ex.toString(), stackTrace: StackTrace.current);
        }
      }
    }
  }

  Future getImage_camera() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        Imagefile = File(pickedFile.path);
      });
      if (Imagefile != null) {
        try {
          FirebaseStorage storage = FirebaseStorage.instance;
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          DocumentReference new_city_ref =
              firestore.collection('chat_message/${Static.id}/message/').doc();
          print(new_city_ref);
          final refimage =
              storage.ref().child('${Static.id}/${new_city_ref.id}.png');
          await refimage.putFile(Imagefile!);
          final url = await refimage.getDownloadURL();
          MessageModel messageModel = MessageModel(
              content: 'User', image: url, sendDate: Timestamp.now());
          new_city_ref.set(messageModel.toMap());
        } catch (ex) {
          log('error)', error: ex.toString(), stackTrace: StackTrace.current);
        }
      }
    }
  }

  void lastdown() {
    if (listScrollController.hasClients) {
      final position = listScrollController.position.maxScrollExtent;
      listScrollController.jumpTo(position);
    }
  }
}
