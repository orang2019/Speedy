import 'package:flutter/cupertino.dart';
import 'package:lastaginfirebase/utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String? id; //todo:?로 null check 하는것보다, required하는게 더 나은ㄴ가 ? id를 왜쓰는지 알고 여기 수정?
  String description;
  bool isDone;
  String? timer;
  dynamic index;


  Todo({
    required this.createdTime,
    required this.title,
    this.description = '',
    this.id,
    this.isDone = false,
    this.timer,
    this.index
  });

  static Todo fromJson(Map<String, dynamic> json) => Todo(
    createdTime: Utils.toDateTime(json['createdTime']),
    title: json['title'],
    description: json['description'],
    id: json['id'],
    isDone: json['isDone'],
    timer: json['timer'],
    index: json['index'],

  );

  Map<String, dynamic> toJson() => {
    'createdTime': Utils.fromDateTimeToJson(createdTime),
    'title': title,
    'description': description,
    'id': id,
    'isDone': isDone,
    'timer': timer,
    'index': index,

  };


}


