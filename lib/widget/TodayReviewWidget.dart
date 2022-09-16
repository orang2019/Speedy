import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lastaginfirebase/provider/todos.dart';
import 'package:lastaginfirebase/widget/todo_widget.dart';


import 'package:intl/intl.dart';

import 'package:lastaginfirebase/timer/timermain.dart';





class TodayReviewWidget extends StatelessWidget {
  const TodayReviewWidget({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {


    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos; //안한놈


    List<dynamic> Todaytasklist = [] ;


    late Map<DateTime,List> groupedEvents = {};
    for (var todo in todos) {
      DateTime date = DateTime(todo.createdTime.year,todo.createdTime.month,todo.createdTime.day, 00 ); // table_calendar 패키지 초기설정때문에 이런형태로 만들어야함
      if (groupedEvents[date]==null) groupedEvents[date] = [];
      groupedEvents[date]!.add(todo);
    }

    String now = DateFormat('yyyy-MM-dd').format(DateTime.now()); //todo : 변수 date의 포멧맞추기 -> 근데 굳이해야할까? 우선 냅둠
    String nowformat = DateFormat('MM-dd').format(DateTime.now());
    DateTime Today = DateTime.parse(now); //String->DateTime

    if (groupedEvents.containsKey(Today)){ Todaytasklist = groupedEvents[Today]!;}  //오늘 해당하는 task list













    return Scaffold(
      // 오늘 복습할것
      body:  Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [


            Container(

                child: Column(

                  children: const [
                    Text('Today',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70),),
                    Text('upgrade',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),)
                  ],
                )),

            Container(
                child:
                Expanded(
                    child:
                      Todaytasklist.isNotEmpty?
                            Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  IconButton(
                                    onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => timermain(Todaytasklist:Todaytasklist)));}
                                      ,icon: const Icon(Icons.play_arrow_rounded)),

                                  const SizedBox(width: 30,height: 30,),
                                  const Icon(Icons.audiotrack_rounded,color: Colors.cyan),
                                  Text("${nowformat}"),
                              Container(width: 10,height: 10,),

                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: Todaytasklist.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [

                                        Text("${Todaytasklist[index].title}"),

                                        Container(width: 10,height: 10,),

                                      ],
                                    );
                                  }),
                            ],
                          ) : Text("오늘의 복습은 없다 얏호")

                        )
                )]
      ),



    );
  }
}
