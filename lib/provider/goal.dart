// hive 로 local 저장
// provider로 local 변수

import 'package:hive/hive.dart';
import 'package:flutter/material.dart';


part 'goal.g.dart'; //hive 세팅2 // 이름 =  여기페이지이름.g.dart


// hive 세팅3
// 패키지 4개 다운
// dependencies:
//   hive: ^[version]
//   hive_flutter: ^[version]
//
// dev_dependencies:
//   hive_generator: ^[version]
//   build_runner: ^[version]
//flutter packages pub run build_runner build

// hive 세팅4
// main.dart 가서 세팅


//hive 세팅1
@HiveType(typeId:0)
class CalendarGoal extends HiveObject {
  @HiveField(0)
  String name; //카테고리
  @HiveField(1)
  DateTime begin;
  @HiveField(2)
  DateTime end;
  @HiveField(4)
  String eventColor;


  CalendarGoal({
    required this.name,
    required this.begin,
    required this.end,
    required this.eventColor,
  });

}