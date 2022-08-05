import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learning_mate_app/chat/chat_bubble_test.dart';
import 'package:learning_mate_app/chat/message_list_screen.dart';
import 'package:learning_mate_app/login/mypage.dart';
import 'package:learning_mate_app/main.dart';
import 'package:learning_mate_app/static.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String nickname = '';
  @override
  void initState() {
    super.initState();
    callNickname();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset("images/MainLogo2.png", width: 200),
          backgroundColor: const Color.fromRGBO(250, 250, 250, 2),
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.interests,
                    color: Color.fromRGBO(255, 128, 0, 10)),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(270, 70),
                    side: const BorderSide(color: Colors.black26, width: 1),
                  ),
                  onPressed: () {
                    // Navigator.pop(context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => const ml()));
                  },
                  child: Image.asset('images/ML.png', width: 250)),
              const SizedBox(height: 30),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(270, 70),
                  side: const BorderSide(color: Colors.black26, width: 1),
                ),
                onPressed: () {
                  // Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => const ml()));
                },
                child: Image.asset('images/DL.png', width: 250),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "${Static.nickname} 님 환영합니다.",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Mypage(),
                          ));
                    },
                    leading: const Icon(
                      Icons.favorite,
                      color: Color.fromRGBO(0, 77, 3, 10),
                    ),
                    title: const Text('MY PAGE'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.calendar_month,
                      color: Color.fromRGBO(0, 77, 3, 10),
                    ),
                    title: const Text('CALENDAR'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.list,
                      color: Color.fromRGBO(0, 77, 3, 10),
                    ),
                    title: const Text('MY LIST'),
                  ),
                  ListTile(
                    onTap: () {
                      Static.id = '';
                      Static.nickname = '';
                      signOut();
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Main()));
                    },
                    leading: const Icon(
                      Icons.logout,
                      color: Color.fromRGBO(0, 77, 3, 10),
                    ),
                    title: const Text('LOGOUT'),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            setState(() {
              //viewon = !viewon;
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MessageListScreen()));
          },
          child: const CircleAvatar(
            backgroundColor: Color.fromRGBO(255, 128, 0, 10),
            radius: 30,
            child: Icon(Icons.question_answer, color: Colors.white),
          ),
        ));
  }

  Future<void> signOut() async {
    await Firebase.initializeApp();

    try {
      await FirebaseAuth.instance.signOut();
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('id', '');
      pref.setString('nickname', '');
    } catch (e) {
      print(e.toString());
    }
  }

  callNickname() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    nickname = pref.getString('nickname')!;
  }
}
