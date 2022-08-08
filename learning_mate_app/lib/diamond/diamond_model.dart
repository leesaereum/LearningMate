import 'package:cloud_firestore/cloud_firestore.dart';

class DiamondModel{
  final String id; //해당 도큐먼트의 ID를 담기위함.
  final String title;
  final String carat;
  final String cut;
  final String color;
  final String clarity;
  final String depth;
  final String table;
  final String x;
  final String y;
  final String z;
  final String result;
  final String date;
  final String lyric;

  DiamondModel({
    this.id = '',
    this.title = '',
    this.carat = '',
    this.cut = '',
    this.color = '',
    this.clarity = '',
    this.depth = '',
    this.table = '',
    this.x = '',
    this.y = '',
    this.z = '',
    this.result = '',
    this.date = '',
    this.lyric = '',
  });

  //서버로부터 map형태의 자료를 MessageModel형태의 자료로 변환해주는 역할을 수행함.
  factory DiamondModel.fromMap(
      {required String id, required Map<dynamic, dynamic> map}) {
    return DiamondModel(
        id: id,
        title: map['title'] ?? '',
        carat: map['carat'] ?? '',
        cut: map['cut'] ?? '',
        color: map['color'] ?? '',
        clarity: map['clarity'] ?? '',
        depth: map['depth'] ?? '',
        table: map['table'] ?? '',
        x: map['x'] ?? '',
        y: map['y'] ?? '',
        z: map['z'] ?? '',
        result: map['result'] ?? '',
        date: map['date'] ?? '',
        lyric: map['lyric'] ?? '',
        );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['title'] = title;
    data['carat'] = carat;
    data['cut'] = cut;
    data['color'] = color;
    data['clarity'] = clarity;
    data['depth'] = depth;
    data['table'] = table;
    data['x'] = x;
    data['y'] = y;
    data['z'] = z;
    data['result'] = result;
    data['date'] = date;
    data['lyric'] = lyric;
    return data;
  }
}
