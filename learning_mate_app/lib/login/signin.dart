import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_mate_app/login/join_model.dart';
import 'package:learning_mate_app/login/loginPage.dart';
import 'package:learning_mate_app/static.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  //property
  // password visible= 안보임이 초기상태
  bool _pwState = true;
  bool _pwagainState = true;
  late String Hint = "";
  TextEditingController id = TextEditingController();
  TextEditingController nickname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController checkpassword = TextEditingController();

  //유효성 검사
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _pwState = true;
    _pwagainState = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Image.asset("images/MainLogo2.png", width: 200),
            backgroundColor: const Color.fromRGBO(250, 250, 250, 2),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 75, 55, 48),
                      ),
                    ),
                    const SizedBox(height: 50),
                    //email
                    Container(
                      height: 100,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextFormField(
                        controller: id,
                        //유효성검사
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "\u26A0 이메일이 필요합니다.";
                          } //email address에 맞지 않으면
                          if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value)) {
                            return '\u26A0 이메일 형식이 아닙니다.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: '이메일',
                            hintText: "이메일을 입력하세요.",
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
                            prefixIcon: const Icon(
                              Icons.email_rounded,
                              color: Color.fromARGB(255, 255, 127, 0),
                            ),
                            //텍스트필드 뒤에 아이콘
                            //clear
                            suffixIcon: id.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        id.clear();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.clear_rounded,
                                      color: Colors.grey,
                                    ))
                                : null),
                      ),
                    ),
                    // nickname
                    Container(
                      height: 100,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: TextFormField(
                        controller: nickname,
                        // 유효성 검사
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "\u26A0 닉네임이 필요합니다.";
                          } //10문자 이내 2문자 이상
                          if (value.length < 2 || value.length > 10) {
                            return "\u26A0 2~10 글자로 작성해주세요.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: '닉네임',
                            hintText: "닉네임을 입력하세요",
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
                              Icons.abc,
                              color: Color.fromARGB(255, 255, 127, 0),
                            ),
                            //텍스트필드 뒤에 아이콘
                            //clear
                            suffixIcon: nickname.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        nickname.clear();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.clear_rounded,
                                      color: Colors.grey,
                                    ))
                                : null),
                      ),
                    ),
                    //pw
                    Container(
                      height: 100,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextFormField(
                        controller: password,
                        //아이콘 누르면 비번 보이게 ,누르기 전 안보임
                        obscureText: _pwState,
                        // 유효성 검사
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "\u26A0 비밀번호가 필요합니다.";
                          } //영어대소문자, 숫자, 특수문자 1자 이상 포함 6자 이상 15자 이내
                          if (!RegExp(
                                  r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{6,15}$')
                              .hasMatch(value)) {
                            return "\u26A0 숫자, 특수문자를 포함해 6~15 글자로 작성해주세요.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: '비밀번호',
                          hintText: "비밀번호를 입력하세요.",
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
                      height: 100,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: TextFormField(
                        controller: checkpassword,
                        //아이콘 누르면 비번 보이게 ,누르기 전 안보임
                        obscureText: _pwagainState,
                        // 유효성 검사
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "\u26A0 비밀번호 확인이 필요합니다.";
                          } //비밀번호와 일치 않음
                          if (value != password.text) {
                            return "\u26A0 비밀번호와 일치하지 않습니다.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: '비밀번호 확인',
                          hintText: "비밀번호 확인을 입력하세요.",
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
                          suffixIcon: _pwagainState
                              ?
                              //true - pw 안보이게
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      //false로 변환
                                      _pwagainState = !_pwagainState;
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
                                      _pwagainState = !_pwagainState;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.black87,
                                  )),
                          //텍스트필드 앞에 아이콘
                          prefixIcon: const Icon(
                            Icons.check_box,
                            color: Color.fromARGB(255, 255, 127, 0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        Hint,
                        style: TextStyle(color: Colors.red[300]),
                      ),
                    ),
                    //submit
                    Container(
                        height: 20.0,
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          Hint,
                          style: TextStyle(color: Colors.red),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 255, 127, 0),
                          minimumSize: const Size(120, 45),
                        ),
                        onPressed: () {
                          //정규식에 유효하면
                          if (formkey.currentState!.validate()) {
                            join();
                          }
                        },
                        child: const Text(
                          '가입',
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  join() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: id.text, password: password.text)
          .then((value) {
        if (value.user!.email == null) {
        } else {
          createNickName();
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Login()));
        }
        return value;
      });
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          Hint = "\u26A0 비밀번호 보안성이 낮습니다. 다시 입력해주세요.";
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          Hint = "\u26A0 중복된 아이디입니다. 다른아이디를 입력해주세요.";
        });
      } else {
        setState(() {
          Hint = "\u26A0 오류가 발생하였습니다.\n 잠시후 다시 시도해주세요.";
        });
      }
    } catch (e) {
      setState(() {
        Hint = "\u26A0 오류가 발생하였습니다.\n 잠시후 다시 시도해주세요.";
      });
    }
  }

  void createNickName() {
    try {
      JoinModel joinModel =
          JoinModel(nickname: nickname.text, createAt: Timestamp.now());

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.collection('user/${id.text}/nickname').add(joinModel.toMap());
    } catch (ex) {
      log('error)', error: ex.toString(), stackTrace: StackTrace.current);
    }
  }
} //end

