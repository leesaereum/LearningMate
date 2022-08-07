import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:learning_mate_app/static.dart';

class calendar extends StatefulWidget {
  const calendar({Key? key}) : super(key: key);

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  // 변수 선언
  List todaycount = []; // 오늘 접속한 기록(['count']0:접속안함,1:접속함)
  //List attendanceDates = []; // 출석한 날짜들(['date']
  int datecount = 0; // 출석한 날짜 수
  DateTime _currentDate = DateTime.now();
  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _currentMonth = DateFormat.E().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  // 이벤트 아이콘 선언
  static final Widget _eventIcon = Image.asset(
    "./images/logo.png", // 로고 이미지
    color: Colors.white.withOpacity(0.8), // 투명도
    colorBlendMode: BlendMode.modulate,
  );

  // 이벤트 선언
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  @override
  void initState() {
    initializeDateFormatting(); // locale
    _currentMonth =
        DateFormat.yMMM('ko_KR').format(DateTime.now()); // 년월 언어 한국어
    attendanceToday();
    attendanceLog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 달력 설정들
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      onDayPressed: (date, events) {
        this.setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(color: Colors.red, fontSize: 20),
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      showHeader: false,
      markedDateShowIcon: true,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      markedDateCustomTextStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      markedDateMoreShowTotal: true,
      // 선택한 날짜 색상
      selectedDayTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      selectedDayButtonColor: Colors.lightGreen,
      selectedDayBorderColor: Colors.lightGreen,
      // 오늘 날짜 색상
      todayTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      todayButtonColor: Colors.amber,
      todayBorderColor: Colors.amber,
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      inactiveDaysTextStyle: const TextStyle(
        color: Colors.tealAccent,
        fontSize: 20,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM('ko_KR').format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
      daysTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
    );

    // 앱 화면
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    top: 30.0,
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          // 년월 출력
                          child: Text(
                        _currentMonth,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      )),
                      TextButton(
                        // 이전 달 넘어가는 버튼
                        child: const Text('PREV'),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year,
                                _targetDateTime.month - 1);
                            _currentMonth = DateFormat.yMMM('ko_KR')
                                .format(_targetDateTime); // 언어 한국어로 변환
                          });
                        },
                      ),
                      TextButton(
                        // 다음 달 넘어가는 버튼
                        child: const Text('NEXT'),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year,
                                _targetDateTime.month + 1);
                            _currentMonth = DateFormat.yMMM('ko_KR')
                                .format(_targetDateTime); // 언어 한국어로 변환
                          });
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _calendarCarouselNoHeader, // 달력 출력
                ),
                Text('이때까지의 출석일은 총 ${datecount.toString()}일 입니다'),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(255, 128, 0, 10)),
                    onPressed: () {
                      attendanceInsert();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('출석체크 : )',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ))
              ],
            ),
          ),
        ));
  }

  // functions

  // 출석 스낵바
  attendanceSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('오늘도 출석하셨군요! 열심히 공부하세요. 화이팅!'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
      ),
    );
  }

  // 오늘 출석 했었는지 확인하는 함수
  attendanceToday() async {
    // var url = Uri.parse(
    //     "http://localhost:8080/Flutter/learningmate/attendanceToday.jsp?user_id=${user_id}");
    // var response = await http.get(url);
    // setState(() {
    //   var JSON = json.decode(utf8.decode(response.bodyBytes));
    //   if (JSON['result'] != null) {
    //     List result = JSON['result'];
    //     todaycount.addAll(result);
    //     print('b');
    //     print(todaycount[0]['count']);
    //     if (todaycount[0]['count'] == '0') { // 오늘 첫 출석 일 경우
    //       attendanceInsert();
    //       // _showDialog(context);
    //       attendanceSnackBar(context);
    //       _markedDateMap.add( // 달력에 오늘 날짜 도장 추가
    //           new DateTime(
    //               int.parse(DateTime.now().toString().substring(0, 4)),
    //               int.parse(DateTime.now().toString().substring(5, 7)),
    //               int.parse(DateTime.now().toString().substring(8, 10))),
    //           new Event(
    //             date: new DateTime.now(),
    //             // title: 'Event 5',
    //             icon: _eventIcon,
    //           ));
    //           datecount = datecount+1; // 도장찍은 날짜 수 1추가
    //     } else {
    //       print('x');
    //     }
    //   } else {
    //     todaycount = [];
    //   }
    // });
  }

  // 오늘 출석 기록 추가하는 함수
  attendanceInsert() {
    final data = {'date': today};
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.collection('check/${Static.id}/check').doc(today).set(data);
      attendanceSnackBar(context);
    } catch (ex) {
      log('error)', error: ex.toString(), stackTrace: StackTrace.current);
    }
  }

  // 지금까지 출석한 날짜 가져오는 함수
  attendanceLog() {
    FirebaseFirestore.instance
        .collection('check/${Static.id}/check')
        .snapshots()
        .listen((data) {
      data.docs.forEach((element) {
        datecount++;
        _markedDateMap.add(
            DateTime(
                int.parse(element['date'].substring(0, 4)),
                int.parse(element['date'].substring(5, 7)),
                int.parse(element['date'].substring(8, 10))),
            Event(
              date: new DateTime(2019, 2, 25),
              // title: 'Event 5',
              icon: _eventIcon,
            ));
      });
    });

    // List<DateModel> attendanceDates = [];
    // snapshots.map((querySnapshot) {
    //   querySnapshot.docs.forEach((element) {
    //     attendanceDates.add(DateModel.fromMap(
    //         id: element.id, map: element.data() as Map<String, dynamic>));
    //     datecount++;
    //   });
    // });

    // int i = 0;
    // while (i < attendanceDates.length) {
    //   // 달력에 지금까지 출석한 날 도장 추가
    //   _markedDateMap.add(
    //       new DateTime(
    //           int.parse(attendanceDates[i].date.substring(
    //                 0,
    //               )),
    //           int.parse(attendanceDates[i].date.substring(5, 7)),
    //           int.parse(attendanceDates[i].date.substring(8, 10))),
    //       new Event(
    //         date: new DateTime(2019, 2, 25),
    //         // title: 'Event 5',
    //         icon: _eventIcon,
    //       ));
    //   i++;
    // }

    // datecount = datecount + attendanceDates.length; // 도장찍은 날짜수 출석한 날짜만큼 추가

    //   var url = Uri.parse(
    //       "http://localhost:8080/Flutter/learningmate/attendanceLog.jsp?user_id=${user_id}");
    //   var response = await http.get(url);
    //   setState(() {
    //     var JSON = json.decode(utf8.decode(response.bodyBytes));
    //     if (JSON['result'] != null) {
    //       List result = JSON['result'];
    //       attendanceDates.addAll(result);
    //       print(result);
    //       int i = 0;
    //       while (i < attendanceDates.length) { // 달력에 지금까지 출석한 날 도장 추가
    //         _markedDateMap.add(
    //             new DateTime(
    //                 int.parse(attendanceDates[i]['date'].substring(0, 4)),
    //                 int.parse(attendanceDates[i]['date'].substring(5, 7)),
    //                 int.parse(attendanceDates[i]['date'].substring(8, 10))),
    //             new Event(
    //               date: new DateTime(2019, 2, 25),
    //               // title: 'Event 5',
    //               icon: _eventIcon,
    //             ));
    //         i++;
    //       }
    //     }
    //     datecount = datecount+attendanceDates.length; // 도장찍은 날짜수 출석한 날짜만큼 추가
    //   });
  }
}

// 매핑용 클래스 생성
class DateModel {
  final String id;
  final String date;

  DateModel({this.id = '', this.date = ''});

  factory DateModel.fromMap(
      {required String id, required Map<dynamic, dynamic> map}) {
    return DateModel(id: id, date: map['date'] ?? '');
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['date'] = date;
    return data;
  }
}
