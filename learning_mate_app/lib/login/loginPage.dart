import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:learning_mate_app/home.dart';
import 'package:learning_mate_app/login/join_model.dart';
import 'package:learning_mate_app/login/signin.dart';
import 'package:learning_mate_app/static.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //password
  // 비번 visible= 안보임이 초기상태
  bool _pwState = true;
  String Hint = "";
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  //유효성 검사
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _pwState = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Image.asset("images/MainLogo2.png", width: 300),
                  const SizedBox(
                    height: 20,
                  ),
                  //id -email
                  Container(
                    height: 120.0,
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: idController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        //빈 값 입력
                        if (value == null || value.isEmpty) {
                          return "\u26A0 이메일을 입력해 주세요";
                        } // 이메일 형식이 아닐경우
                        if (!RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value)) {
                          return '\u26A0 이메일 형식이 아닙니다.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "\u26A0 이메일을 입력해 주세요",
                          labelText: '이메일',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 75, 55, 48)),
                          // 배경색  채우기
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          //에러 스타일 - 클릭 안할시
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(47, 95, 79, 65))),
                          //에러 테두리 - 클릭할시
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(133, 86, 59, 43))),
                          //클릭시  보이는 테두리
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(133, 86, 59, 43))),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(47, 95, 79, 65))),
                          //텍스트필드 맨 앞 아이콘
                          prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: Color.fromARGB(255, 255, 127, 0),
                          ),
                          //텍스트필드 뒤에 아이콘
                          //clear
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  idController.clear();
                                });
                              },
                              icon: const Icon(
                                Icons.clear_rounded,
                                color: Colors.grey,
                              ))),
                    ),
                  ),
                  //pw
                  Container(
                    height: 120.0,
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: pwController,
                      keyboardType: TextInputType.text,
                      //아이콘 누르면 비번 보이게 ,누르기 전 안보임
                      obscureText: _pwState,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "\u26A0 비밀번호를 입력해주세요";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "비밀번호를 입력해 주세요",
                        labelText: '비밀번호',
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 75, 55, 48)),
                        // 배경색  채우기
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        //에러 스타일 - 클릭 안할시
                        errorBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(47, 95, 79, 65))),
                        //에러 테두리 - 클릭할시
                        focusedErrorBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(133, 86, 59, 43))),
                        //클릭할 시 보이는 테두리
                        focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(133, 86, 59, 43))),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(47, 95, 79, 65))),
                        //텍스트필드 뒤에 아이콘
                        suffixIcon: _pwState
                            ?
                            //true - pw 안보이게
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    //false로 변환
                                    _pwState = !_pwState;
                                  });
                                },
                                icon: const Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ))
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    //true로 반환
                                    _pwState = !_pwState;
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.black87,
                                )),
                        //텍스트필드 앞에 아이콘
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: Color.fromARGB(255, 255, 127, 0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 30.0, top: 5.0),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 10,
                          ),
                          Text(Hint,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.red[300]))
                        ],
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                      onPressed: () {
                        if (!RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(idController.text)) {
                          setState(() {
                            Hint = '비밀번호 재전송을 위해 \n 등록된 이메일을 입력해주세요.';
                          });
                        } else {
                          sendmail();
                        }
                      },
                      child: const Text(
                        '비밀번호 재설정 메일 전송',
                        style: TextStyle(color: Color.fromARGB(255, 0, 77, 3)),
                      )),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        //아이디, 비번 둘다 정규식에 유효하면 홈으로가기
                        _login();
                      }
                    },
                    icon: const Icon(
                      Icons.login,
                      size: 32,
                    ),
                    label: const Text(
                      "로그인",
                      style: TextStyle(fontSize: 19),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 255, 127, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(120, 45),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Signin(),
                            ));
                      },
                      icon: const Icon(
                        Icons.email_rounded,
                        size: 32,
                      ),
                      label: const Text(
                        "이메일로 가입하기",
                        style: TextStyle(fontSize: 19),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 255, 127, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(250, 45),
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //functions
  // 로그인
  _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: idController.text,
              password: pwController.text) //아이디와 비밀번호로 로그인 시도
          .then((value) {
        if (value.user!.emailVerified == true) //이메일 인증 여부
        {
          callNickname();
          Static.id = idController.text;
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Home()));
        } else {
          setState(() {
            //error unicode
            Hint = "\u26A0 인증이 완료된 아이디인지 확인해주세요.";
          });
        }
        return value;
      });
    } on FirebaseAuthException catch (e) {
      //로그인 예외처리
      if (e.code == 'user-not-found') {
        setState(() {
          //error unicode
          Hint = "\u26A0 존재하지 않는 아이디입니다.";
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          //error unicode
          Hint = "\u26A0 비밀번호가 맞지 않습니다.";
        });
      } else {
        print(e.code);
      }
    }
  }

  // 로그인 성공 시 닉네임 불러오기
  callNickname() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('id', idController.text);
    FirebaseFirestore.instance
        .collection('user/${idController.text}/nickname')
        .orderBy('createAt', descending: true)
        .snapshots()
        .listen((data) {
      int i = 0;
      data.docs.forEach((element) {
        if (i == 0) {
          pref.setString('nickname', element['nickname']);
          Static.nickname = element['nickname'];
        }
        i++;
      });
    });
  }

  // 비밀번호 재설정 메일 전송
  Future sendmail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: idController.text);
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
//END
