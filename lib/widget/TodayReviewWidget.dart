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

    //
    // List<dynamic> Todaytitlelist = [] ; //?? ["복습없음"] // todo : 빈상태로 보내지면, initstate안에 넣기
    // List<dynamic> Todaynotelist = [] ;
    // List<dynamic> Todaytimelist = [] ;
    // List<dynamic> Todaytasklist = [] ;
    //
    //
    //
    // List<Iterable> ListTaskTitle = [];
    // List<Iterable> ListTaskNote = [];
    // List<Iterable> ListTaskTime = [];
    // List<Iterable> ListTask = [];
    //
    //
    //
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos; //안한놈
    // Set setDate = todos.map((e) => e.createdTime).toSet(); //set 이라 서로다른 날짜가져옴.
    // List<dynamic> listDate = setDate.toList(); //list로 다시바꿈.    [ "8/27/22", "8/28/22" ..... ]
    // for (String i in  listDate){
    //   Iterable newlist = todos.where((e) => e.createdTime == i ); // 날짜와 같은 Task
    //   Iterable newlistTitle = newlist.map((e) => e.title).toList(); // Task중에 title
    //   Iterable newlistNote = newlist.map((e) => e.note).toList(); // Task중에 note
    //   Iterable newlistTime = newlist.map((e) => e.time).toList(); // Task중에 time
    //
    //   ListTask.add(newlist); // 날짜와 같은 task // [["8/26/22"tasks ],["8/27/22"tasks], ... 오늘총8개 ,내일16개,.... ]
    //
    //   ListTaskTitle.add(newlistTitle); // [["8/26/22"title],["8/27/22"title] ]
    //   ListTaskNote.add(newlistNote);
    //   ListTaskTime.add(newlistTime);
    // }


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
                                    onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => timermain(Todaytasklist)));},icon: const Icon(Icons.play_arrow_rounded)),

                               // nPressed:(){Get.to(()=> todayreview(Todaytasklist,Todaytitlelist,Todaynotelist,Todaytimelist));} , icon: const Icon(Icons.play_arrow_rounded)),
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
