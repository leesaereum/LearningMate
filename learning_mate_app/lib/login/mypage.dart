import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learning_mate_app/home.dart';
import 'package:learning_mate_app/login/Login.dart';
import 'package:learning_mate_app/login/join_model.dart';
import 'package:learning_mate_app/login/loginPage.dart';
import 'package:learning_mate_app/static.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mypage extends StatefulWidget {
  const Mypage({Key? key}) : super(key: key);

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  TextEditingController nickname = TextEditingController();
  bool invisible = true;

  @override
  void initState() {
    super.initState();
    nickname.text = Static.nickname;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
              const Text(
                '마이페이지',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text('${Static.nickname}님의 정보',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: TextField(
                  controller: nickname,
                  decoration: InputDecoration(
                    labelText: '닉네임',
                    hintText: '새 닉네임을 입력하세요',
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
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 255, 127, 0)),
                      onPressed: () {
                        modify();
                      },
                      child: const Text(
                        '닉네임 수정',
                        style: TextStyle(fontSize: 20),
                      )),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 255, 110, 110)),
                      onPressed: () {
                        sendAlert();
                      },
                      child: const Text(
                        '비밀번호 재설정',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
              TextButton(
                  onPressed: () {
                    deleteAlert();
                    //Navigator.pop(context);
                  },
                  child: const Text(
                    'Learning Mate 회원 탈퇴',
                    style: TextStyle(color: Colors.grey),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  deleteAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('회원 탈퇴'),
            content: const Text('회원 탈퇴시 모든 정보는 삭제됩니다.\n회원 탈퇴를 진행할까요?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      deleteAccount();
                    },
                    child: const Text(
                      '네',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 4, 31, 56)),
                    ),
                  ),
                  const SizedBox(width: 40),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '아니요',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 4, 31, 56)),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  sendAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('비밀번호 재설정'),
            content: const Text('현재 로그인된 이메일로 비밀번호 재설정 메일을 전송하겠습니까?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      sendmail();
                    },
                    child: const Text(
                      '예',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 4, 31, 56)),
                    ),
                  ),
                  const SizedBox(width: 40),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '아니요',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 4, 31, 56)),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  modify() async {
    try {
      JoinModel joinModel =
          JoinModel(nickname: nickname.text, createAt: Timestamp.now());

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.collection('user/${Static.id}/nickname').add(joinModel.toMap());

      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('nickname', nickname.text);
      _showdialog(context);
    } catch (ex) {
      log('error)', error: ex.toString(), stackTrace: StackTrace.current);
      errorSnackbar(context);
    }
  }

  _showdialog(BuildContext context) {
    setState(() {
      Static.nickname = nickname.text;
    });
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('닉네임 변경이 완료되었습니다.'),
      duration: Duration(seconds: 2),
      backgroundColor: Color.fromARGB(255, 4, 31, 56),
    ));
  }

  errorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("오류 발생 :(\n잠시후 재시도 해주세요."),
      duration: Duration(seconds: 1),
      backgroundColor: Colors.red,
    ));
  }

  // 회원 탈퇴
  deleteAccount() async {
    try {
      await FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          user.delete();
        }
      });
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('id', '');
      pref.setString('nickname', '');

      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginMain(),
          ));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('회원탈퇴가 완료되었습니다.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("오류 발생 :(\n잠시후 재시도 해주세요."),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future sendmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: Static.id);
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: const Text('비밀번호 재설정'),
            content: const Text(
                '비밀번호 재설정 메일을 전송하였습니다. \n 입력하신 이메일 주소의 메일함을 확인해주세요.'),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 255, 127, 0)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('닫기'))
            ],
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
