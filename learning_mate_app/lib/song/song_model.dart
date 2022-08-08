// import 'package:cloud_firestore/cloud_firestore.dart';

// class SongModel{
//   final String id; //해당 도큐먼트의 ID를 담기위함.
//   final String title;
//   final String lyric;
//   final String result;
//   final String date;

//   SongModel({
//     this.id = '',
//     this.title = '',
//     this.lyric = '',
//     this.result = '',
//     this.date = '',
//   });

//   //서버로부터 map형태의 자료를 MessageModel형태의 자료로 변환해주는 역할을 수행함.
//   factory SongModel.fromMap(
//       {required String id, required Map<dynamic, dynamic> map}) {
//     return SongModel(
//         id: id,
//         title: map['title'] ?? '',
//         lyric: map['lyric'] ?? '',
//         result: map['result'] ?? '',
//         date: map['date'] ?? ''
//         );
//   }

//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> data = {};
//     data['title'] = title;
//     data['lyric'] = lyric;
//     data['result'] = result;
//     data['date'] = date;
//     return data;
//   }
// }
