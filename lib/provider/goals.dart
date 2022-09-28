import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'goal.dart';

import 'package:cr_calendar/cr_calendar.dart';



class GoalsProvider extends ChangeNotifier {
  final Box goalbox = Hive.box<CalendarGoal>('goals');


  void addGoal(CalendarGoal goal) async{

    // events.add(goal); //value = 리스트 형태로 hive 저장
    final Box goalbox = Hive.box<CalendarGoal>('goals');

    await goalbox.add(goal); //put = 딕셔너리 꼴로 저장, add = 단순 value 저장
    notifyListeners();
    //수정후엔 rebuild
  }

  //todo : 정말 지우겠습니까 ? 팝업창
  //deleteGoal

  void deleteGoal(CalendarGoal goal) async{

    final Map<dynamic, dynamic> goalMap = goalbox.toMap();
    goalMap.forEach((key, value) {
      if ((goal.name==value.name)&&(goal.begin==value.begin)&&(goal.end==value.end)){ goalbox.delete(key);}
    });
    notifyListeners();

  }











}