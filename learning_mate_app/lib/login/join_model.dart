import 'package:cloud_firestore/cloud_firestore.dart';

class JoinModel {
  final String id; //해당 도큐먼트의 ID를 담기위함.
  final String nickname;
  final Timestamp createAt;

  JoinModel({
    this.id = '',
    this.nickname = '',
    Timestamp? createAt,
  }) : createAt = createAt ?? Timestamp(0, 0);

  //서버로부터 map형태의 자료를 MessageModel형태의 자료로 변환해주는 역할을 수행함.
  factory JoinModel.fromMap(
      {required String id, required Map<dynamic, dynamic> map}) {
    return JoinModel(
        id: id,
        nickname: map['nickname'] ?? '',
        createAt: map['createAt'] ?? Timestamp(0, 0));
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['nickname'] = nickname;
    data['createAt'] = createAt;
    return data;
  }
}
