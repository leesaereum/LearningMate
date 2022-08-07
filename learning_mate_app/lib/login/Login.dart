import 'package:flutter/material.dart';
import 'package:learning_mate_app/login/loginPage.dart';
import 'package:learning_mate_app/login/signin.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset("images/MainLogo2.png", width: 200),
          backgroundColor: const Color.fromRGBO(250, 250, 250, 2),
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "./images/logo.png",
                width: 120,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    //ff7f00
                    primary: const Color.fromRGBO(255, 128, 0, 10)),
                onPressed: () {
                  //Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ));
                },
                child: Image.asset('images/LoginLogo.png', width: 250),
              ),
              const SizedBox(height: 30),
              const Text(
                '러닝메이트가 처음이신가요?',
                style: TextStyle(color: Colors.black54),
              ),
              TextButton(
                  onPressed: () {
                    //Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Signin()));
                  },
                  child: const Text(
                    '회원가입 하러 가기',
                    style: TextStyle(color: Color.fromARGB(255, 0, 77, 3)),
                  ))
            ],
          ),
        ));
  }
}
