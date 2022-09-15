import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lastaginfirebase/provider/todos.dart';

//getx, hive
import 'package:intl/intl.dart';
//캘린더

import 'package:flutter/foundation.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:provider/provider.dart';
import 'package:lastaginfirebase/provider/todos.dart';
import 'package:lastaginfirebase/widget/todo_widget.dart';

import 'package:lastaginfirebase/api/firebase_api.dart';





// void main() {
//   initializeDateFormatting().then((_) => runApp(MaterialApp(  //캘린더한국어
//     home:CalendarWidget() ,
//   )));}



// class CalendarMain extends StatelessWidget {
//   const CalendarMain({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     //stful 과 provider은 함께 쓸 수 없다.
//     final provider = Provider.of<TodosProvider>(context);
//     final todos = provider.todos;
//
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(child: SizedBox(child: CalendarWidget())),
//           Expanded(child: Container(child: CalendarText()))]));
//           // todos.isEmpty
//           //     ? Center(
//           //     child: Text('No todos.', style: TextStyle(fontSize: 20),),)
//           //     : ListView.separated(
//           //     shrinkWrap: true,
//           //     physics: BouncingScrollPhysics(),
//           //     padding: EdgeInsets.all(16), //card간 분리
//           //     separatorBuilder: (context, index) => Container(height: 8),
//           //     itemCount: todos.length,
//           //     itemBuilder: (context, index) {
//           //     final todo = todos[index];
//           //
//           //     return TodoWidget(todo: todo);
//           //     },
//           //     )
//
//
//   }
// }







class CalendarWidget extends StatefulWidget {
  CalendarWidget({Key? key}) : super(key: key);


  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  bool isSelect = false; // 여기둬야 selct했을때 true로 바뀜.



  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  //todo
  /// 아래뭔지 모르겠음
  /// focusedDay 가 잘못된거 ?
  /// headerstyle 바꿔도 안됨.
  /// 일단 깃허브에 저장 ㄲㄱ


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializeDateFormatting(Localizations.localeOf(context).languageCode);
  } // 한국어 사용하려면 날짜 초기화해야함.




  final dateFormat = DateFormat('EEEE yyyy-MMMM-dd');

  @override
  Widget build(BuildContext context) {
    // 주의 ! 이 위치에 둬야하는 이유
    // 1 - CalendarWidget 이 completed 한 후에, provider 이 나와야한다. initstate 안에 provider 을 넣으면 안된다.
    // 2 - 이유는 모른다,위에다 두면 계속 rebuild 되어서 groupedEvents[date]!.add 가 계속된다. 여기두면 한번만 시행되는듯 근데 계속 null 떠서 나중에 확인하기.
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;
    late Map<DateTime,List> groupedEvents = {};
    for (var todo in todos) {
      DateTime date = DateTime.utc(todo.createdTime.year,todo.createdTime.month,todo.createdTime.day, 00 ); // table_calendar 패키지 초기설정때문
      if (groupedEvents[date]==null) groupedEvents[date] = [];
      groupedEvents[date]!.add(todo);
    }

    late List selectedEvents = groupedEvents[selectedDay] ?? [];

    DateTime today = DateTime.now();
    late List todayEvents = groupedEvents[DateTime.utc(today.year, today.month,today.day,00)] ?? []; //오늘날짜만 캘린더탭들어가자마자 보이기. 탭안하면 안보이니까 그러나 이게 최선인진모르겠음.









    return Scaffold(
      body: SingleChildScrollView(

          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      SizedBox(
                        child: Card(
                              clipBehavior: Clip.antiAlias,

                              child: TableCalendar(

                                focusedDay: DateTime.now(),
                                firstDay: DateTime(2022),
                                lastDay: DateTime(2030),
                                locale: 'ko-KR',
                                daysOfWeekVisible: true, //요일 삭제
                                startingDayOfWeek: StartingDayOfWeek.monday, //월요일부터
                                availableGestures: AvailableGestures.all,

                                onDaySelected: (DateTime selectDay, DateTime focuseDay) {
                                  setState(() {
                                    selectedDay = selectDay;
                                    focusedDay = focuseDay;
                                    isSelect =true;
                                  });
                                },

                                selectedDayPredicate: (DateTime date) {
                                  return isSameDay(selectedDay, date);
                                },

                                onPageChanged: (focuseDay) {
                                  focusedDay = focuseDay;
                                },





                                calendarBuilders: CalendarBuilders(

                                    markerBuilder: (context, date, events) {
                                      return groupedEvents[date] != null ? Icon(Icons.check,color: Colors.black) : Container() ;
                                    }
                                ),

                                //UI (기능X)
                                calendarStyle: CalendarStyle(
                                  isTodayHighlighted: true,

                                  todayDecoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  selectedDecoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  weekendDecoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  defaultDecoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  outsideDecoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  selectedTextStyle: TextStyle(color: Colors.white),

                                ),


                                headerStyle: HeaderStyle(
                                  titleTextStyle: const TextStyle(fontSize: 25.0),
                                  titleTextFormatter: (date, locale) => DateFormat.M(locale).format(date), // 월 만 표기. (지금이몇년도인지알게뭐람?)

                                  formatButtonVisible: false,
                                  titleCentered: true,
                                  leftChevronVisible: false,
                                  rightChevronVisible: false,
                                  formatButtonShowsNext: false,

                                ),
                              ),
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                        child: Text(
                          DateFormat('EEEE, dd MMMM, yyyy').format(selectedDay),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),

                      SizedBox(

                        //streambuilder로 감싸져 있어서인지 계속 rebuild되는것같다. 여기뿐아니라 감싸진 코드 전부다.

                          // child : Eventlist(todayEvents,selectedEvents)
                        child: isSelect == false
                            ? ListView.separated(
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            padding: EdgeInsets.all(16), //card간 분리
                                            separatorBuilder: (context, index) => Container(height: 8),

                                            itemCount: todayEvents.length,
                                            itemBuilder: (context, index) {
                                              final todo = todayEvents[index];
                                              return TodoWidget(todo: todo);
                                            })
                            : selectedEvents.isEmpty ? Center(child: Text('No todos.', style: TextStyle(fontSize: 20),))
                                : ListView.separated(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.all(16), //card간 분리
                                separatorBuilder: (context, index) => Container(height: 8),

                                itemCount: selectedEvents.length,
                                itemBuilder: (context, index) {
                                  final todo = selectedEvents[index];
                                  return TodoWidget(todo: todo);
                                })




                      ),


                    ]
                )));
            }}


  Eventlist(todayEvents,selectedEvents) {
    if(todayEvents.isNotEmpty){
      ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16), //card간 분리
        separatorBuilder: (context, index) => Container(height: 8),

        itemCount: todayEvents.length,
        itemBuilder: (context, index) {
          final todo = todayEvents[index];
          return TodoWidget(todo: todo);
        });}
    else if(selectedEvents.isNotEmpty){ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16), //card간 분리
        separatorBuilder: (context, index) => Container(height: 8),

        itemCount: selectedEvents.length,
        itemBuilder: (context, index) {
          final todo = selectedEvents[index];
          return TodoWidget(todo: todo);
        });}

    else{Center(child: Text('No todos.', style: TextStyle(fontSize: 20),));}
  }

